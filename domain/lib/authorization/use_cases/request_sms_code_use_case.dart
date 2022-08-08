part of authorization;

class RequestSmsCodeUseCase extends FutureUseCase<void, RequestSmsCodePayload> {
  final AuthRepository _authRepository;

  RequestSmsCodeUseCase({
    required AuthRepository authRepository,
  }) : _authRepository = authRepository;

  @override
  Future<SmsCodeResult> execute(RequestSmsCodePayload params) async {
    return _authRepository.requestSmsCode(payload: params);
  }
}
