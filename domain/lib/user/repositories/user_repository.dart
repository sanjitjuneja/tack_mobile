part of user;

abstract class UserRepository {
  Stream<User> get userStream;

  User get currentUser;
}
