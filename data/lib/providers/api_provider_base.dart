import 'package:core/core.dart';
import 'package:data/errors/error_handler.dart';
import 'package:data/providers/access_provider.dart';
import 'package:data/query/api_query.dart';
import 'package:dio/dio.dart';

class ApiProviderBase {
  final String _baseUrl;
  final ErrorHandler _errorHandler;
  final AccessProvider _accessProvider;

  final Dio _dio = Dio();

  ApiProviderBase({
    required String baseUrl,
    required AccessProvider accessProvider,
    required ErrorHandler errorHandler,
  })  : _baseUrl = baseUrl,
        _accessProvider = accessProvider,
        _errorHandler = errorHandler {
    _setupDio(
      dio: _dio,
      baseUrl: baseUrl,
    );
  }

  Future<T> get<T>(ApiQuery query) async {
    return safeRequest(() async {
      final Response<T> response = await _dio.get(
        query.endpointPostfix,
        queryParameters: query.params,
      );

      return response.data!;
    });
  }

  Future<T> post<T>(
    Function parse,
    ApiQuery query, {
    bool isFormData = false,
  }) async {
    return safeRequest(() async {
      final Response response = await _dio.post(
        query.endpointPostfix,
        data: isFormData ? query.formDataBody : query.jsonEncodedBody,
        queryParameters: query.params,
      );

      return parse(response.data!);
    });
  }

  Future<void> put(ApiQuery query) async {
    return safeRequest(() async {
      await _dio.put(
        query.endpointPostfix,
        data: query.body,
        queryParameters: query.params,
      );
    });
  }

  Future<void> patch(ApiQuery query) async {
    return safeRequest(() async {
      await _dio.patch(
        query.endpointPostfix,
        data: query.body,
        queryParameters: query.params,
      );
    });
  }

  Future<void> delete(ApiQuery query) async {
    return safeRequest(() async {
      await _dio.delete(
        query.endpointPostfix,
        data: query.body,
        queryParameters: query.params,
      );
    });
  }

  Future<T> safeRequest<T>(Future<T> Function() request) async {
    try {
      return await request();
    } on DioError catch (e) {
      print('-=-=-=-=-=-=-=-=-=-=-=-=');
      print(e.error);
      print(e.response);
      print(e.message);
      print('-=-=-=-=-=-=-=-=-=-=-=-=');
      return _errorHandler.handleError(e);
    }
  }

  void _setupDio({
    required Dio dio,
    required String baseUrl,
  }) {
    dio.options.baseUrl = baseUrl;
    dio.interceptors.add(
      InterceptorsWrapper(onRequest:
          (RequestOptions options, RequestInterceptorHandler handler) async {
        final String? accessToken = await _accessProvider.getAccessToken();
        if (accessToken != null) {
          options.headers[Constants.keyAuthorization] =
              Constants.keyBearer + accessToken;
        }
        return handler.next(options);
      }, onError: (DioError error, ErrorInterceptorHandler handler) async {
        //TODO: Replace with repository solution
        if (error.response?.statusCode == 401) {
          final String? refreshToken =
              await _accessProvider.getRefreshTokenIfItActual();
          if (refreshToken != null) {
            final String newAccessToken = await _refreshToken(refreshToken);
            await _accessProvider.saveAccessToken(accessToken: newAccessToken);

            error.requestOptions.headers[Constants.keyAuthorization] =
                Constants.keyBearer + newAccessToken;

            final Options newOptions = Options(
              method: error.requestOptions.method,
              headers: error.requestOptions.headers,
            );

            try {
              final Response<dynamic> response = await dio.request(
                error.requestOptions.path,
                data: error.requestOptions.data,
                queryParameters: error.requestOptions.queryParameters,
                options: newOptions,
              );
              handler.resolve(response);
            } catch (_) {
              handler.next(error);
            }
          } else {
            _errorHandler.handleError(error);
          }
        } else {
          handler.next(error);
        }
      }),
    );
  }

  Future<String> _refreshToken(String refreshToken) async {
    final String refreshTokenUrl = '${_baseUrl}refresh/';

    final Map<String, String> body = <String, String>{
      Constants.keyRefresh: refreshToken,
    };

    final dynamic responseData = await safeRequest(() async {
      final Response<dynamic> response = await _dio.post(
        refreshTokenUrl,
        data: body,
      );
      return response.data;
    });

    return (responseData as Map<String, dynamic>)[Constants.keyAccess]
        as String;
  }
}
