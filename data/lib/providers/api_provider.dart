import 'package:core/constants/base_url_constants.dart';
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
          MessageEntity.fromJson,
          ApiQuery(
            params: null,
            body: request.toJson(),
            endpointPostfix: BaseUrlConstants.loginPath,
          ),
        )
        .then(mapper.messageMapper.fromEntity);
  }

  Future<domain.Customer> signUp({
    required RegisterUserByPhoneRequest request,
  }) async {
    return await _apiProviderBase
        .post<UserEntity>(
          UserEntity.fromJson,
          ApiQuery(
            params: null,
            body: request.toJson(),
            endpointPostfix: BaseUrlConstants.signUpPath,
          ),
        )
        .then(mapper.customerMapper.fromEntity);
  }

  Future<domain.SmsCodeResult> requestSmsCode({
    required String endpointPostfix,
    required SmsCodeRequest request,
  }) async {
    return _apiProviderBase
        .post<SmsVerificationEntity>(
          SmsVerificationEntity.fromJson,
          ApiQuery(
            endpointPostfix: endpointPostfix,
            body: request.toJson(),
            params: null,
          ),
        )
        .then(mapper.smsVerificationMapper.fromEntity);
  }

  Future<domain.PhoneVerificationResult> verifyPhoneNumber({
    required VerifyPhoneNumberRequest request,
  }) async {
    return _apiProviderBase
        .post<PhoneVerificationEntity>(
          PhoneVerificationEntity.fromJson,
          ApiQuery(
            params: null,
            body: request.toJson(),
            endpointPostfix: BaseUrlConstants.verifyPhoneNumberPath,
          ),
        )
        .then(mapper.phoneVerificationMapper.fromEntity);
  }

  Future<domain.Group> createGroup({
    required CreateGroupRequest request,
  }) async {
    return _apiProviderBase
        .post<GroupEntity>(
          GroupEntity.fromJson,
          ApiQuery(
            endpointPostfix: BaseUrlConstants.groupsPath,
            body: request.toJson(),
            params: null,
          ),
          isFormData: true,
        )
        .then(mapper.groupMapper.fromEntity);
  }

  Future<List<domain.Tack>> getMyTacks() async {
    return _apiProviderBase
        .get<List<TackEntity>>(
          ApiQuery(
            endpointPostfix: BaseUrlConstants.tacksMePath,
            body: null,
            params: null,
          ),
        )
        .then(mapper.tackMapper.fromList);
  }

  Future<void> updateTack(UpdateTackRequest request) async {
    return _apiProviderBase.put(
      ApiQuery(
        endpointPostfix: '${BaseUrlConstants.tacks}${request.id}',
        body: request.toJson(),
        params: null,
      ),
    );
  }

  Future<void> rateTack(RateTackRequest request) async {
    return _apiProviderBase.get<void>(
      ApiQuery(
        endpointPostfix: BaseUrlConstants.reviews,
        body: request.toJson(),
        params: null,
      ),
    );
  }
}
