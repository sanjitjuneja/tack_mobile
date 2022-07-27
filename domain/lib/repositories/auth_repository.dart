import '../auth/phone_verification.dart';
import '../user/user.dart';

abstract class AuthRepository {
  Future<Message> signIn({
    required SignInPayload payload,
  });

  Future<Customer> signUp({
    required SignUpByPhonePayload params,
  });
}
