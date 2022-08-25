part of user;

class ChangePasswordUseCase extends FutureUseCase<void, ChangePasswordPayload> {
  final UserRepository _userRepository;

  ChangePasswordUseCase({
    required UserRepository userRepository,
  }) : _userRepository = userRepository;

  @override
  Future<void> execute(ChangePasswordPayload params) {
    return _userRepository.changePassword(params);
  }
}
