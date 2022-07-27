abstract class ForgotPasswordEvent {}

class SubmitNewPassword extends ForgotPasswordEvent {
  final String password;
  final String confirmedPassword;

  SubmitNewPassword({
    required this.password,
    required this.confirmedPassword,
  });
}

class ValidatePassword extends ForgotPasswordEvent {
  final String password;

  ValidatePassword({
    required this.password,
  });
}

class ValidateConfirmedPassword extends ForgotPasswordEvent {
  final String password;

  ValidateConfirmedPassword({
    required this.password,
  });
}

class ChangePassword extends ForgotPasswordEvent {
  final String password;
  final String confirmedPassword;

  ChangePassword({
    required this.password,
    required this.confirmedPassword,
  });
}

class GetVerificationCode extends ForgotPasswordEvent {}
