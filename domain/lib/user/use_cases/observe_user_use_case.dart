part of user;

class ObserveUserUseCase extends StreamUseCase<User, NoParams> {
  final UserRepository _userRepository;

  ObserveUserUseCase({
    required UserRepository userRepository,
  }) : _userRepository = userRepository;

  @override
  Stream<User> execute(NoParams params) {
    return _userRepository.userStream;
  }
}
