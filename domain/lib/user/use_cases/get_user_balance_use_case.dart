part of user;

class GetUserBalanceUseCase extends UseCase<UserBankAccount, NoParams> {
  final UserRepository _userRepository;

  GetUserBalanceUseCase({
    required UserRepository userRepository,
  }) : _userRepository = userRepository;

  @override
  UserBankAccount execute(NoParams params) {
    return _userRepository.balance;
  }
}
