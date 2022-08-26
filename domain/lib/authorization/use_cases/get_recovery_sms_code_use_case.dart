part of authorization;

class GetRecoverySmsCodeUseCase
    extends FutureUseCase<SmsCodeResult, RequestSmsCodePayload> {
  final AuthRepository _authRepository;

  GetRecoverySmsCodeUseCase({
    required AuthRepository authRepository,
  }) : _authRepository = authRepository;

  @override
  Future<SmsCodeResult> execute(RequestSmsCodePayload params) async {
    return _authRepository.requestRecoverySmsCode(payload: params);
  }
}
