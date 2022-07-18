import 'package:core/constants/base_url_constants.dart';
import 'package:data/providers/api_provider_base.dart';
import 'package:domain/models/request_sms_code_result.dart';

import '../query/api_query.dart';

class ApiProvider {
  final String _baseUrl;
  final ApiProviderBase _apiProviderBase;

  ApiProvider({
    required String baseUrl,
    required ApiProviderBase apiProviderBase,
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
    ) as Map<String, dynamic>;
  }
}
