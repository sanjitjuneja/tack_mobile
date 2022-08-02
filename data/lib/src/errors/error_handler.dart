import 'package:core/core.dart';
import 'package:dio/dio.dart';

class ErrorHandler {
  Future<Never> handleError(DioError error) async {
    final Response<dynamic>? response = error.response;
    if (!await InternetConnectionService.isConnected) {
      throw NoInternetConnection();
    } else if (response == null) {
      throw BackendException();
    } else {
      final int? statusCode = response.statusCode;
      if (statusCode != null) {
        if (statusCode == 400) {
          final Map<String, dynamic> errors =
              response.data as Map<String, dynamic>;

          final Map<String, String> parsedErrors = <String, String>{};
          for (int index = 0; index < errors.length; index++) {
            final dynamic errorValue = errors.values.elementAt(index);
            if (errorValue is List<dynamic>) {
              parsedErrors[errors.keys.elementAt(index)] =
                  errorValue.first.toString();
            }
          }

          final bool isUserExisted = isUserExist(parsedErrors);
          if (isUserExisted) {
            throw ExistedUserException();
          }

          //TODO: Add error parsing logic here
          throw AppException('');
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

  bool isUserExist(Map<String, String> errors) {
    if (errors.isNotEmpty) {
      return errors.containsValue(
        'User with this phone number already exists.',
      );
    }
    return false;
  }
}
