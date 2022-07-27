part of phone_verification;

class SignInPayload {
  final String password;
  final String phoneNumber;

  SignInPayload({
    required this.password,
    required this.phoneNumber,
  });
}
