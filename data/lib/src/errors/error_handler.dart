import 'dart:io';

import 'package:core/core.dart';
import 'package:dio/dio.dart';

class ErrorHandler {
  final List<LayerErrorHandler> _layerHandlers = <LayerErrorHandler>[];

  ErrorHandler({LayerErrorHandler? layerErrorHandler}) {
    if (layerErrorHandler != null) {
      _layerHandlers.add(layerErrorHandler);
    }
  }

  void addLayerHandler(LayerErrorHandler layerErrorHandler) {
    _layerHandlers.add(layerErrorHandler);
  }

  void removeLayerHandler<T>() {
    _layerHandlers.removeWhere((LayerErrorHandler element) => element is T);
  }

  Never handleError(Object error) {
    final AppException appException;

    if (error is DioError) {
      appException = _parseDioError(error: error);
    } else if (error is SocketException) {
      appException = const AppSocketException();
    } else {
      appException = const AppException(
        code: ErrorCode.unknown,
        messageKey: 'errors.unknown',
      );
    }

    if (_layerHandlers.isNotEmpty) {
      throw _layerHandlers.last.proceedError(appException);
    } else {
      throw appException;
    }
  }

  AppException _parseDioError({required DioError error}) {
    final Response<dynamic>? response = error.response;
    final int? statusCode = response?.statusCode;

    if (statusCode != null) {
      if (statusCode == 401) {
        return const UnauthorizedException();
      } else if (statusCode == 403) {
        return const NoPermissionsException();
      } else if (statusCode == 400) {
        final Map<String, dynamic> error =
            response!.data as Map<String, dynamic>;

        final String? backEndErrorCode = error['error'];
        final String? message = error['message'];

        return _parseBackEndError(
          backEndErrorCode: backEndErrorCode,
          message: message,
        );
      } else if (statusCode == 500) {
        return const InternalBackendException();
      } else if (statusCode == 502) {
        return const BadGatewayException();
      }
    } else if (error.type == DioErrorType.other) {
      if (error.message.contains('${const SocketException('').runtimeType}')) {
        return const AppSocketException();
      }
    }

    return const AppException(
      code: ErrorCode.unknown,
      messageKey: 'errors.unknown',
    );
  }

  AppException _parseBackEndError({
    required String? backEndErrorCode,
    required String? message,
  }) {
    switch (backEndErrorCode) {
      case ErrorCode.smsRequestAttemptsExceeded:
        return const SmsRequestAttemptsExceededException();
      case ErrorCode.logInAttemptsExceeded:
        return const LogInAttemptsExceededException();
      case ErrorCode.wrongCredentials:
        return const WrongCredentialsException();
      case ErrorCode.wrongPassword:
        return const WrongPasswordException();
      case ErrorCode.phoneNumberNotFound:
        return const PhoneNumberNotFoundException();
      case ErrorCode.phoneNumberAlreadyExist:
        return const PhoneNumberAlreadyExistException();
      case ErrorCode.emailAlreadyExist:
        return const EmailAlreadyExistException();
      case ErrorCode.hasOngoingGroupTacks:
        return const HasOngoingGroupTacksException();
      case ErrorCode.transactionLimit:
        return const TransactionsLimitException();
      case ErrorCode.hasActiveTacks:
        return const HasActiveTacksException();
      case ErrorCode.hasNotEmptyBalance:
        return const HasNotEmptyBalanceException();
      default:
        final bool hasMessage = message == null || message.isEmpty;

        return AppException(
          code: backEndErrorCode ?? ErrorCode.unknown,
          message: message,
          messageKey: hasMessage ? null : 'errors.unknown',
        );
    }
  }
}
