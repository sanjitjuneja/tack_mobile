abstract class ForgotPasswordEvent {}

class SubmitNewPassword extends ForgotPasswordEvent {
  final String password;
  final String confirmedPassword;

  SubmitNewPassword({
    required this.password,
    required this.confirmedPassword,
  });
}

class GetVerificationCode extends ForgotPasswordEvent{}
