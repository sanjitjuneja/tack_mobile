part of user;

abstract class UserRepository {
  Stream<User> get userStream;

  User get currentUser;

  Stream<UserBankAccount> get balanceStream;

  UserBankAccount get balance;

  Future<void> initialLoad();

  Future<UserBankAccount> fetchUserBalance(FetchUserBalancePayload payload);

  Future<UserContacts> fetchUserContacts(FetchUserContactsPayload payload);

  Future<User> updateUserInfo(UpdateUserInfoPayload payload);

  Future<void> changePassword(ChangePasswordPayload payload);
}
