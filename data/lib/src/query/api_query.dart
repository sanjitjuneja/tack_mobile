library api_query;

import 'dart:convert';

import 'package:dio/dio.dart';

part 'base_url_constants.dart';

class ApiQuery {
  static const String idKey = '{id}';

  final String endpoint;
  final dynamic id;
  final Map<String, dynamic>? params;
  final Map<String, dynamic>? body;

  String get path {
    String finalPath = endpoint.replaceAll(idKey, id.toString());
    final hasEndSlash = finalPath.endsWith('/');

    if (hasEndSlash) return finalPath;

    return '$finalPath/';
  }

  String get jsonEncodedBody => jsonEncode(body);

  FormData? get formDataBody => body != null ? FormData.fromMap(body!) : null;

  ApiQuery({
    required this.endpoint,
    required this.body,
    required this.params,
    this.id,
  });
}
