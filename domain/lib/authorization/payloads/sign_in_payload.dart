part of authorization;

class SignInPayload {
  final String login;
  final String password;

  const SignInPayload({
    required this.login,
    required this.password,
  });
}
