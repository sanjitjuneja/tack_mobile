part of authorization;

class VerifyPhoneNumberUseCase
    extends FutureUseCase<PhoneVerificationResult, VerifyPhoneNumberPayload> {
  final AuthRepository _authRepository;

  VerifyPhoneNumberUseCase({
    required AuthRepository authRepository,
  }) : _authRepository = authRepository;

  @override
  Future<PhoneVerificationResult> execute(
    VerifyPhoneNumberPayload params,
  ) async {
    return _authRepository.verifyPhoneNumber(params: params);
  }
}
