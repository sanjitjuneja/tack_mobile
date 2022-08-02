import 'package:data/entities/groups/groups.dart';
import 'package:data/entities/tacks/tacks.dart';
import 'package:data/mappers/mappers.dart';
import 'package:data/providers/api_provider_base.dart';
import 'package:domain/domain.dart' as domain;

import '../entities/phone_verification/phone_verification.dart';
import '../entities/user/user.dart';
import '../query/api_query.dart';

class ApiProvider {
  final ApiProviderBase _apiProviderBase;
  final MapperFactory mapper;

  ApiProvider({
    required ApiProviderBase apiProviderBase,
    required this.mapper,
  }) : _apiProviderBase = apiProviderBase;

  Future<domain.Message> signIn({
    required SignInRequest request,
  }) async {
    return _apiProviderBase
        .post<MessageEntity>(
          ApiQuery(
            endpoint: BaseUrlConstants.loginPath,
            params: null,
            body: request.toJson(),
          ),
          parser: MessageEntity.fromJson,
        )
        .then(mapper.messageMapper.fromEntity);
  }

  Future<domain.Customer> signUp({
    required RegisterUserByPhoneRequest request,
  }) async {
    return await _apiProviderBase
        .post<UserEntity>(
          ApiQuery(
            endpoint: BaseUrlConstants.signUpPath,
            params: null,
            body: request.toJson(),
          ),
          parser: UserEntity.fromJson,
        )
        .then(mapper.customerMapper.fromEntity);
  }

  Future<domain.SmsCodeResult> requestSighUpSmsCode({
    required SmsCodeRequest request,
  }) async {
    return _apiProviderBase
        .post<SmsVerificationEntity>(
          ApiQuery(
            endpoint: BaseUrlConstants.requestSmsCodeSignUpPath,
            body: request.toJson(),
            params: null,
          ),
          parser: SmsVerificationEntity.fromJson,
        )
        .then(mapper.smsVerificationMapper.fromEntity);
  }

  Future<domain.SmsCodeResult> requestResetPasswordSmsCode({
    required SmsCodeRequest request,
  }) async {
    return _apiProviderBase
        .post<SmsVerificationEntity>(
          ApiQuery(
            endpoint: BaseUrlConstants.requestSmsCodeResetPasswordPath,
            body: request.toJson(),
            params: null,
          ),
          parser: SmsVerificationEntity.fromJson,
        )
        .then(mapper.smsVerificationMapper.fromEntity);
  }

  Future<domain.PhoneVerificationResult> verifyPhoneNumber({
    required VerifyPhoneNumberRequest request,
  }) async {
    return _apiProviderBase
        .post<PhoneVerificationEntity>(
          ApiQuery(
            endpoint: BaseUrlConstants.verifyPhoneNumberPath,
            params: null,
            body: request.toJson(),
          ),
          parser: PhoneVerificationEntity.fromJson,
        )
        .then(mapper.phoneVerificationMapper.fromEntity);
  }

  Future<domain.Group> createGroup({
    required CreateGroupRequest request,
  }) async {
    return _apiProviderBase
        .post<GroupEntity>(
          ApiQuery(
            endpoint: BaseUrlConstants.groupsPath,
            body: request.toJson(),
            params: null,
          ),
          parser: GroupEntity.fromJson,
          isFormData: true,
        )
        .then(mapper.groupMapper.fromEntity);
  }

  Future<List<domain.Tack>> getMyTacks() async {
    return _apiProviderBase
        .get<List<TackEntity>>(
          ApiQuery(
            endpoint: BaseUrlConstants.tacksMePath,
            body: null,
            params: null,
          ),
          parser: TackEntity.listFromJson,
        )
        .then(mapper.tackMapper.fromList);
  }

  Future<List<domain.Tack>> getGroupTacks(GroupTacksRequest request) async {
    return _apiProviderBase
        .get<List<TackEntity>>(
          ApiQuery(
            endpoint: BaseUrlConstants.groupsTacksPath,
            id: request.groupId,
            body: null,
            params: null,
          ),
          parser: TackEntity.listFromJson,
        )
        .then(mapper.tackMapper.fromList);
  }

  Future<void> updateTack(UpdateTackRequest request) async {
    return _apiProviderBase.put(
      ApiQuery(
        endpoint: BaseUrlConstants.tacksWithId,
        id: request.id,
        body: request.toJson(),
        params: null,
      ),
    );
  }

  Future<void> rateTack(RateTackRequest request) async {
    return _apiProviderBase.post<void>(
      ApiQuery(
        endpoint: BaseUrlConstants.reviews,
        body: request.toJson(),
        params: null,
      ),
      parser: (_) {},
    );
  }
}
