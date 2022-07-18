abstract class SignInState {}

class SignInContent extends SignInState {
  final bool isDataValid;
  final Map<String, String>? errors;

  SignInContent({
    required this.isDataValid,
    this.errors,
  });
}
