part of user;

class FetchUserBalanceUseCase
    extends FutureUseCase<UserBankAccount, FetchUserBalancePayload> {
  final UserRepository _userRepository;

  FetchUserBalanceUseCase({
    required UserRepository userRepository,
  }) : _userRepository = userRepository;

  @override
  Future<UserBankAccount> execute(FetchUserBalancePayload params) {
    return _userRepository.fetchUserBalance(params);
  }
}
