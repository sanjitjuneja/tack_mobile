part of user;

class ObserveUserBalanceUseCase
    extends StreamUseCase<UserBankAccount, NoParams> {
  final UserRepository _userRepository;

  ObserveUserBalanceUseCase({
    required UserRepository userRepository,
  }) : _userRepository = userRepository;

  @override
  Stream<UserBankAccount> execute(NoParams params) {
    return _userRepository.balanceStream;
  }
}
