import 'dart:io';

import 'package:data/src/helpers/entity_helper/entities_helpers.dart';
import 'package:data/src/errors/error_handler.dart';
import 'package:data/src/query/api_query.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

abstract class ApiProviderCore {
  final ErrorHandler _errorHandler;

  late Dio _dio;

  ApiProviderCore({
    required String baseUrl,
    required ErrorHandler errorHandler,
    void Function(Dio)? additionalSetup,
  }) : _errorHandler = errorHandler {
    _setup(baseUrl);
    additionalSetup?.call(_dio);
  }

  void _setup(String baseUrl) {
    _dio = Dio();
    _dio.options.responseType = ResponseType.json;
    _dio.options.baseUrl = baseUrl;
    _dio.options.contentType = ContentType.json.value;

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
  Future<void> patch(ApiQuery query) async {
    return _safeRequest<void>(
      request: _dio.patch(
        query.path,
        data: query.body,
        queryParameters: query.params,
      ),
      parser: (_) {},
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
      } else {
        /// TODO: fix. String is not Map<String, dynamic> for response with 204 code (DELETE).
        return parser(<String, dynamic>{});
      }
    } on DioError catch (e) {
      return _errorHandler.handleError(e);
    }
  }
}
