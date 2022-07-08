import 'dart:convert';

import 'package:dio/dio.dart';

class ApiQuery {
  final Map<String, dynamic>? params;
  final Map<String, dynamic>? body;

  String get jsonEncodedBody => jsonEncode(body);

  final String endpointPostfix;

  ApiQuery({
    required this.endpointPostfix,
    required this.params,
    required this.body,
  });
}

class ApiQueryWithFormData {
  final Map<String, dynamic>? params;
  final FormData? body;
  final String endpointPostfix;

  ApiQueryWithFormData({
    required this.endpointPostfix,
    required this.params,
    required this.body,
  });
}
