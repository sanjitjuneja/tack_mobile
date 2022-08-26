part of user;

abstract class UserRepository {
  Stream<User> get userStream;

  User get currentUser;

  Future<User> updateUserInfo(UpdateUserInfoPayload payload);

  Future<void> changePassword(ChangePasswordPayload payload);
}
