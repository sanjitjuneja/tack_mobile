import 'package:core/core.dart';
import 'package:dio/dio.dart';

class ErrorHandler {
  // TODO: refactor error handler.
  Future<Never> handleError(DioError error) async {
    final Response<dynamic>? response = error.response;
    if (!await InternetConnectionService.isConnected) {
      throw NoInternetConnection();
    } else if (response == null) {
      throw BackendException();
    } else {
      final int? statusCode = response.statusCode;
      if (statusCode != null) {
        if (statusCode == 400 || statusCode == 401) {
          final Map<String, dynamic> errors =
              response.data as Map<String, dynamic>;

          final Map<String, dynamic> parsedErrors = errors.map(
            (String key, dynamic value) {
              final MapEntry<String, dynamic> entry =
                  MapEntry<String, dynamic>(key, value);

              return entry;
            },
          );

          _parseError(parsedErrors);
        }

        if (statusCode == 401) {
          throw Exception(error.toString());
        }

        if (statusCode >= 500) {
          throw BackendException();
        }
      }

      throw Exception(error.toString());
    }
  }

  Never _parseError(Map<String, dynamic> errors) {
    // TODO: refactor after BE changes.
    final String value = errors.values.toString();
    if (value.contains('Incorrect password')){
      throw IncorrectPasswordException();
    }
    if (value.contains('User with the given phone number is not found')) {
      throw UserNotRegisteredException();
    }
    if (value.contains('User with this email already exists.')) {
      throw EmailAlreadyUsedException();
    }
    if (value.contains('User with this phone number already exists.')) {
      throw ExistedUserException();
    }
    if (value.contains('No active account found with the given credentials')) {
      throw WrongCredentialsException();
    }

    throw AppException('');
  }
}
