part of phone_verification;

class RequestSmsCodeUseCase extends FutureUseCase<void, RequestSmsCodePayload> {
  final PhoneVerificationRepository _phoneNumberRepository;

  RequestSmsCodeUseCase({
    required PhoneVerificationRepository phoneNumberRepository,
  }) : _phoneNumberRepository = phoneNumberRepository;

  @override
  Future<SmsCodeResult> execute(RequestSmsCodePayload params) async {
    return _phoneNumberRepository.requestSmsCode(payload: params);
  }
}
