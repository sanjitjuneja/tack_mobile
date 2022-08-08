part of authorization;

class IsAuthorizedUseCase extends FutureUseCase<bool, NoParams> {
  final AuthRepository _authRepository;

  IsAuthorizedUseCase({
    required AuthRepository authRepository,
  }) : _authRepository = authRepository;

  @override
  Future<bool> execute(NoParams params) async {
    return _authRepository.isAuthorized();
  }
}
