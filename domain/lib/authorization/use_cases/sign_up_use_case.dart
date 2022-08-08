part of authorization;

class SignUpUseCase extends FutureUseCase<void, SignUpByPhonePayload> {
  final AuthRepository _authRepository;

  SignUpUseCase({
    required AuthRepository authRepository,
  }) : _authRepository = authRepository;

  @override
  Future<User> execute(SignUpByPhonePayload params) async {
    return _authRepository.signUp(params: params);
  }
}
