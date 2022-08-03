part of authorization;

class SignInUseCase extends FutureUseCase<User, SignInPayload> {
  final AuthRepository _authRepository;

  SignInUseCase({
    required AuthRepository authRepository,
  }) : _authRepository = authRepository;

  @override
  Future<User> execute(SignInPayload params) async {
    return _authRepository.signIn(payload: params);
  }
}
