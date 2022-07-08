import 'package:core/errors/app_exception.dart';
import 'package:core/errors/backend_exception.dart';
import 'package:core/errors/no_internet_exception.dart';
import 'package:core/utils/internet_connectivity_service.dart';
import 'package:dio/dio.dart';

class ErrorHandler {
  void handleError(DioError error) async {
    final Response<dynamic>? response = error.response;
    if (!await InternetConnectionService.isConnected) {
      throw NoInternetConnection();
    } else if (response == null) {
      throw BackendException();
    } else {
      final int? statusCode = response.statusCode;
      if (statusCode != null) {
        if (statusCode == 400) {
          final Map<String, dynamic> map =
              response.data as Map<String, dynamic>;

          //TODO: Add error parsing logic here
          throw AppException('');
        }

        if (statusCode == 401) {
          //TODO: Add handle server access
        }

        if (statusCode >= 500) {
          throw BackendException();
        }
      }

      throw Exception(error.toString());
    }
  }
}
