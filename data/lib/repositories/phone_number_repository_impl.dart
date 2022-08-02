import 'package:data/data.dart';

import '../entities/phone_verification/phone_verification.dart';

import 'package:domain/domain.dart' as domain;

class PhoneNumberRepositoryImpl implements domain.PhoneVerificationRepository {
  final ApiProvider _apiProvider;

  PhoneNumberRepositoryImpl({
    required ApiProvider apiProvider,
    required PrefsProvider prefsProvider,
  }) : _apiProvider = apiProvider;

  @override
  Future<domain.SmsCodeResult> requestSmsCode({
    required domain.RequestSmsCodePayload payload,
  }) async {
    final SmsCodeRequest request =
        SmsCodeRequest(phoneNumber: payload.phoneNumber);

    if (payload.phoneVerificationType == domain.PhoneVerificationType.signUp) {
      return _apiProvider.requestSighUpSmsCode(request: request);
    } else {
      return _apiProvider.requestResetPasswordSmsCode(request: request);
    }
  }

  @override
  Future<domain.PhoneVerificationResult> verifyPhoneNumber({
    required domain.VerifyPhoneNumberPayload params,
  }) async {
    return _apiProvider.verifyPhoneNumber(
      request: VerifyPhoneNumberRequest(
        uuid: params.uuid,
        smsCode: params.smsCode,
      ),
    );
  }
}
