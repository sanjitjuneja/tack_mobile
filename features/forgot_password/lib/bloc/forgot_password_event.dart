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
  final String confirmedPassword;

  ValidatePassword({
    required this.password,
    required this.confirmedPassword,
  });
}

class ValidateConfirmedPassword extends ForgotPasswordEvent {
  final String password;
  final String confirmedPassword;

  ValidateConfirmedPassword({
    required this.password,
    required this.confirmedPassword,
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
