part of phone_verification;

class VerifyPhoneNumberUsecase
    extends FutureUseCase<void, VerifyPhoneNumberPayload> {
  final PhoneVerificationRepository _phoneNumberRepository;

  VerifyPhoneNumberUsecase({
    required PhoneVerificationRepository phoneNumberRepository,
  }) : _phoneNumberRepository = phoneNumberRepository;

  @override
  Future<PhoneVerificationResult> execute(
      VerifyPhoneNumberPayload params) async {
    return _phoneNumberRepository.verifyPhoneNumber(params: params);
  }
}
