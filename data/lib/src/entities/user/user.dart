library user_entities;

import 'package:data/src/helpers/entity_helper/entities_helpers.dart';
import 'package:dio/dio.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:domain/domain.dart' as domain;

part 'entities/sign_in_response.dart';
part 'entities/user_bank_account_entity.dart';
part 'entities/user_entity.dart';

part 'requests/register_user_by_phone_request.dart';
part 'requests/user_request.dart';
part 'requests/sign_in_request.dart';

part 'user.g.dart';
