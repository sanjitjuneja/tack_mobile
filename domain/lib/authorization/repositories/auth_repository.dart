part of authorization;

abstract class AuthRepository {
  Future<PhoneVerificationResult> verifyPhoneNumber({
    required VerifyPhoneNumberPayload params,
  });

  Future<SmsCodeResult> requestSignUpSmsCode({
    required RequestSmsCodePayload payload,
  });

  Future<SmsCodeResult> requestRecoverySmsCode({
    required RequestSmsCodePayload payload,
  });

  Future<User> signIn({
    required SignInPayload payload,
  });

  Future<User> signUp({
    required SignUpByPhonePayload payload,
  });

  Future<void> recoveryChangePassword({
    required RecoveryChangePasswordPayload payload,
  });

  Future<bool> isAuthorized();

  Future<void> logout();
}
