part of authorization;

class ChangePasswordRecoveryUseCase
    extends FutureUseCase<void, RecoveryChangePasswordPayload> {
  final AuthRepository _authRepository;

  ChangePasswordRecoveryUseCase({
    required AuthRepository authRepository,
  }) : _authRepository = authRepository;

  @override
  Future<void> execute(RecoveryChangePasswordPayload params) async {
    return _authRepository.recoveryChangePassword(payload: params);
  }
}
