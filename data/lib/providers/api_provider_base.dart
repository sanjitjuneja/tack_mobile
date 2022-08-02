import 'package:core/core.dart';
import 'package:data/helpers/entity_helper/entities_helpers.dart';
import 'package:data/errors/error_handler.dart';
import 'package:data/providers/access_provider.dart';
import 'package:data/query/api_query.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

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

  Future<T> get<T>(
    ApiQuery query, {
    required T Function(Map<String, dynamic>) parser,
  }) async {
    return await safeRequest<T>(
      () => _dio.get(
        query.path,
        queryParameters: query.params,
      ),
      parser: parser,
    );
  }

  Future<T> post<T>(
    ApiQuery query, {
    required Parser<T> parser,
    bool isFormData = false,
  }) async {
    return safeRequest<T>(
      () => _dio.post(
        query.path,
        data: isFormData ? query.formDataBody : query.jsonEncodedBody,
        queryParameters: query.params,
      ),
      parser: parser,
    );
  }

  Future<void> put(ApiQuery query) async {
    return safeRequest<void>(
      () => _dio.put(
        query.path,
        data: query.body,
        queryParameters: query.params,
      ),
      parser: (_) {},
    );
  }

  Future<void> patch(ApiQuery query) async {
    return safeRequest<void>(
      () => _dio.patch(
        query.path,
        data: query.body,
        queryParameters: query.params,
      ),
      parser: (_) {},
    );
  }

  Future<void> delete(ApiQuery query) async {
    return safeRequest<void>(
      () => _dio.delete(
        query.path,
        data: query.body,
        queryParameters: query.params,
      ),
      parser: (_) {},
    );
  }

  Future<T> safeRequest<T>(
    Future<Response> Function() request, {
    required T Function(Map<String, dynamic>) parser,
  }) async {
    try {
      final Response response = await request();

      return parser(response.data!);
    } on DioError catch (e) {
      return _errorHandler.handleError(e);
    }
  }

  void _setupDio({
    required Dio dio,
    required String baseUrl,
  }) {
    dio.options.baseUrl = baseUrl;
    if (kDebugMode) {
      dio.interceptors.add(LogInterceptor());
    }
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (
          RequestOptions options,
          RequestInterceptorHandler handler,
        ) async {
          final String? accessToken = await _accessProvider.getAccessToken();
          if (accessToken != null) {
            options.headers[Constants.keyAuthorization] =
                Constants.keyBearer + accessToken;
          }
          return handler.next(options);
        },
        onError: (DioError error, ErrorInterceptorHandler handler) async {
          //TODO: Replace with repository solution
          if (error.response?.statusCode == 401) {
            final String? refreshToken =
                await _accessProvider.getRefreshTokenIfItActual();
            if (refreshToken != null) {
              final String newAccessToken = await _refreshToken(refreshToken);
              await _accessProvider.saveAccessToken(
                  accessToken: newAccessToken);

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
        },
      ),
    );
  }

  Future<String> _refreshToken(String refreshToken) async {
    final String refreshTokenUrl = '${_baseUrl}refresh/';

    final Map<String, String> body = <String, String>{
      Constants.keyRefresh: refreshToken,
    };

    final dynamic responseData = await safeRequest(
      () async {
        final Response<dynamic> response = await _dio.post(
          refreshTokenUrl,
          data: body,
        );
        return response.data;
      },
      parser: (_) => _,
    );

    return (responseData as Map<String, dynamic>)[Constants.keyAccess]
        as String;
  }
}
