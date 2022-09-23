part of user;

class FetchUserUseCase extends FutureUseCase<User, NoParams> {
  final UserRepository _userRepository;

  FetchUserUseCase({
    required UserRepository userRepository,
  }) : _userRepository = userRepository;

  @override
  Future<User> execute(NoParams params) {
    return _userRepository.fetchUser();
  }
}
