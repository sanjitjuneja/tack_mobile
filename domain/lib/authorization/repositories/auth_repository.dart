part of authorization;

abstract class AuthRepository {
  Future<SmsCodeResult> requestSmsCode({
    required RequestSmsCodePayload payload,
  });

  Future<PhoneVerificationResult> verifyPhoneNumber({
    required VerifyPhoneNumberPayload params,
  });

  Future<User> signIn({
    required SignInPayload payload,
  });

  Future<User> signUp({
    required SignUpByPhonePayload params,
  });

  Future<bool> isAuthorized();

  Future<void> logout();
}
