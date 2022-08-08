library entities_helpers;

import 'dart:io';

import 'package:dio/dio.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:path/path.dart' as path;

part 'converters.dart';
part 'list_parser_mixin.dart';

typedef Parser<T> = T Function(Map<String, dynamic>);
