part of user;

class DeleteAccountUseCase extends FutureUseCase<void, DeleteAccountPayload> {
  final UserRepository _userRepository;

  DeleteAccountUseCase({
    required UserRepository userRepository,
  }) : _userRepository = userRepository;

  @override
  Future<void> execute(DeleteAccountPayload params) {
    return _userRepository.deleteAccount(params);
  }
}
