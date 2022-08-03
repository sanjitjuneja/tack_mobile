library user;

import 'package:dio/dio.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:domain/domain.dart' as domain;

part 'entities/user_entity.dart';
part 'entities/message_entity.dart';
part 'entities/sign_in_response.dart';

part 'requests/register_user_by_phone_request.dart';
part 'requests/user_request.dart';
part 'requests/sign_in_request.dart';

part 'user.g.dart';
