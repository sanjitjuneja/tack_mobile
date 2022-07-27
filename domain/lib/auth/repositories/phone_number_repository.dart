part of phone_verification;

abstract class PhoneVerificationRepository {
  Future<SmsCodeResult> requestSmsCode({
    required RequestSmsCodePayload payload,
  });

  Future<PhoneVerificationResult> verifyPhoneNumber({
    required VerifyPhoneNumberPayload params,
  });
}
