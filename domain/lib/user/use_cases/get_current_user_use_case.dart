part of user;

class GetCurrentUserUseCase extends UseCase<User, NoParams> {
  final UserRepository _userRepository;

  GetCurrentUserUseCase({
    required UserRepository userRepository,
  }) : _userRepository = userRepository;

  @override
  User execute(NoParams params) {
    return _userRepository.currentUser;
  }
}
