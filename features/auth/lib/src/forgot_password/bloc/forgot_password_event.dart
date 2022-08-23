part of 'forgot_password_bloc.dart';

abstract class ForgotPasswordEvent {
  const ForgotPasswordEvent();
}

class PasswordChanged extends ForgotPasswordEvent {
  final String password;

  const PasswordChanged({
    required this.password,
  });
}

class PasswordConfirmationChanged extends ForgotPasswordEvent {
  final String password;

  const PasswordConfirmationChanged({
    required this.password,
  });
}

class SubmitNewPasswordAction extends ForgotPasswordEvent {
  const SubmitNewPasswordAction();
}
