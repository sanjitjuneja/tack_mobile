import 'package:core/constants/base_url_constants.dart';
import 'package:data/entities/groups/groups.dart';
import 'package:data/entities/tacks/tacks.dart';
import 'package:data/mappers/mappers.dart';
import 'package:data/providers/api_provider_base.dart';
import 'package:domain/domain.dart' as domain;
import 'package:domain/models/request_sms_code_result.dart';

import '../query/api_query.dart';

class ApiProvider {
  final String _baseUrl;
  final ApiProviderBase _apiProviderBase;
  final MapperFactory mapper;

  ApiProvider({
    required String baseUrl,
    required ApiProviderBase apiProviderBase,
    required this.mapper,
  })  : _baseUrl = baseUrl,
        _apiProviderBase = apiProviderBase;

  Future<void> signIn({
    required Map<String, dynamic> signInBody,
  }) async {
    final Map<String, dynamic> map = await _apiProviderBase.post(
      ApiQuery(
        params: null,
        body: signInBody,
        endpointPostfix: BaseUrlConstants.loginPath,
      ),
    ) as Map<String, dynamic>;

    print('0--0-0-0-0-0-0-0-0-0');
    print(map);
  }

  Future<void> signUp({
    required Map<String, dynamic> signUpBody,
  }) async {
    final Map<String, dynamic> map = await _apiProviderBase.post(
      ApiQuery(
        params: null,
        body: signUpBody,
        endpointPostfix: BaseUrlConstants.signUpPath,
      ),
    ) as Map<String, dynamic>;
  }

  Future<RequestSmsCodeResult> requestSmsCode({
    required Map<String, dynamic> requestSmsCodeBody,
  }) async {
    print(3);
    print(requestSmsCodeBody);
    final dynamic k = await _apiProviderBase.post(
      ApiQuery(
        params: null,
        body: requestSmsCodeBody,
        endpointPostfix: BaseUrlConstants.requestSmsCodePath,
      ),
    );
    print(k);
    final Map<String, dynamic> map = await _apiProviderBase.post(
      ApiQuery(
        params: null,
        body: requestSmsCodeBody,
        endpointPostfix: BaseUrlConstants.requestSmsCodePath,
      ),
    ) as Map<String, dynamic>;

    print('-=-=-=-=-==-=-=-=-=-=-=-==-=-=-=-=-=-');
    print(map);
    print('-=-=-=-=-==-=-=-=-=-=-=-==-=-=-=-=-=-');
    return RequestSmsCodeResult.fromMap(map);
  }

  Future<void> verifyPhoneNumber({
    required Map<String, dynamic> verifyPhoneNumberBody,
  }) async {
    final Map<String, dynamic> map = await _apiProviderBase.post(
      ApiQuery(
        params: null,
        body: verifyPhoneNumberBody,
        endpointPostfix: BaseUrlConstants.verifyPhoneNumberPath,
      ),
    );
  }

  Future<domain.Group> createGroup({
    required CreateGroupRequest request,
  }) async {
    return _apiProviderBase
        .post<GroupEntity>(
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
}
