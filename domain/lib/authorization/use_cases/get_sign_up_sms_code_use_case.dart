part of authorization;

class GetSignUpSmsCodeUseCase
    extends FutureUseCase<SmsCodeResult, RequestSmsCodePayload> {
  final AuthRepository _authRepository;

  GetSignUpSmsCodeUseCase({
    required AuthRepository authRepository,
  }) : _authRepository = authRepository;

  @override
  Future<SmsCodeResult> execute(RequestSmsCodePayload params) async {
    return _authRepository.requestSignUpSmsCode(payload: params);
  }
}
