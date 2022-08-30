part of user;

class FetchUserContactsUseCase
    extends FutureUseCase<UserContacts, FetchUserContactsPayload> {
  final UserRepository _userRepository;

  FetchUserContactsUseCase({
    required UserRepository userRepository,
  }) : _userRepository = userRepository;

  @override
  Future<UserContacts> execute(FetchUserContactsPayload params) {
    return _userRepository.fetchUserContacts(params);
  }
}
