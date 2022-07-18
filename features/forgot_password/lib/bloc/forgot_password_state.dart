abstract class ForgotPasswordState {}

class ForgotPasswordContent extends ForgotPasswordState {
  final Map<String, String>? errors;

  ForgotPasswordContent({
    this.errors,
  });
}
