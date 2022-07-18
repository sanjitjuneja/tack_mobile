import 'dart:io';

import 'package:dio/dio.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:path/path.dart' as path;

class FileConverter implements JsonConverter<File, MultipartFile> {
  const FileConverter();

  @override
  File fromJson(MultipartFile? multipartFile) {
    assert(
      multipartFile != null,
      'From json is not supported for MultipartFile',
    );
    return File('');
  }

  @override
  MultipartFile toJson(File file) {
    return MultipartFile.fromBytes(
      file.readAsBytesSync(),
      filename: path.basename(file.path),
    );
  }
}

class DateTimeConverter implements JsonConverter<DateTime?, String?> {
  const DateTimeConverter();

  @override
  DateTime? fromJson(String? json) {
    if (json == null) return null;

    return DateTime.tryParse(json);
  }

  @override
  String? toJson(DateTime? json) => json?.toIso8601String();
}

class DoubleConverter implements JsonConverter<double, String> {
  const DoubleConverter();

  @override
  double fromJson(String json) => double.parse(json);

  @override
  String toJson(double json) => json.toString();
}
