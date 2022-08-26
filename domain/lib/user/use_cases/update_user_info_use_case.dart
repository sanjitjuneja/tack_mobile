part of user;

class UpdateUserInfoUseCase extends FutureUseCase<User, UpdateUserInfoPayload> {
  final UserRepository _userRepository;

  UpdateUserInfoUseCase({
    required UserRepository userRepository,
  }) : _userRepository = userRepository;

  @override
  Future<User> execute(UpdateUserInfoPayload params) {
    return _userRepository.updateUserInfo(params);
  }
}
