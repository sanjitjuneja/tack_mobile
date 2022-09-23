import 'dart:io';

import 'package:core/core.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../helpers/entity_helper/entities_helpers.dart';
import '../errors/error_handler.dart';
import '../query/api_query.dart';

abstract class ApiProviderCore {
  final ErrorHandler _errorHandler;

  late Dio _dio;

  ApiProviderCore({
    required AppConfig appConfig,
    required ErrorHandler errorHandler,
    void Function(Dio)? additionalSetup,
  }) : _errorHandler = errorHandler {
    _setup(appConfig);
    additionalSetup?.call(_dio);
  }

  void _setup(AppConfig appConfig) {
    _dio = Dio();
    _dio.options.responseType = ResponseType.json;
    _dio.options.baseUrl = appConfig.baseUrl;
    _dio.options.contentType = ContentType.json.value;
    _dio.options.headers.addAll(appConfig.flavorHeader);

    if (kDebugMode) {
      _dio.interceptors.add(
        LogInterceptor(requestBody: true, responseBody: true),
      );
    }
  }

  @protected
  Future<T> get<T>(
    ApiQuery query, {
    required Parser<T> parser,
  }) async {
    return _safeRequest<T>(
      request: _dio.get(
        query.path,
        queryParameters: query.params,
      ),
      parser: parser,
    );
  }

  @protected
  Future<T> post<T>(
    ApiQuery query, {
    required Parser<T> parser,
    bool isFormData = false,
  }) async {
    return _safeRequest<T>(
      request: _dio.post(
        query.path,
        data: isFormData ? query.formDataBody : query.jsonEncodedBody,
        queryParameters: query.params,
      ),
      parser: parser,
    );
  }

  @protected
  Future<T> put<T>(
    ApiQuery query, {
    required Parser<T> parser,
  }) async {
    return _safeRequest<T>(
      request: _dio.put(
        query.path,
        data: query.body,
        queryParameters: query.params,
      ),
      parser: parser,
    );
  }

  @protected
  Future<T> patch<T>(
    ApiQuery query, {
    required Parser<T> parser,
  }) async {
    return _safeRequest<T>(
      request: _dio.patch(
        query.path,
        data: query.body,
        queryParameters: query.params,
      ),
      parser: parser,
    );
  }

  @protected
  Future<void> delete(ApiQuery query) async {
    return _safeRequest<void>(
      request: _dio.delete(
        query.path,
        data: query.body,
        queryParameters: query.params,
      ),
      parser: (_) {},
    );
  }

  @protected
  Future<T> _safeRequest<T>({
    required Future<Response> request,
    required Parser<T> parser,
  }) async {
    try {
      final Response response = await request;

      if (response.data is Map<String, dynamic>) {
        return parser(response.data!);
      } else if (response.data is List<dynamic>) {
        //TODO: fix.
        return parser(
          <String, dynamic>{'results': response.data},
        );
      } else {
        /// TODO: fix. String is not Map<String, dynamic> for response with 204 code (DELETE).
        return parser(<String, dynamic>{});
      }
    } catch (e) {
      return _errorHandler.handleError(e);
    }
  }
}
