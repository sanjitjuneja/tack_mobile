part of 'change_password_bloc.dart';

abstract class ChangePasswordEvent {
  const ChangePasswordEvent();
}

class OldPasswordChanged extends ChangePasswordEvent {
  final String password;

  const OldPasswordChanged({
    required this.password,
  });
}

class PasswordChanged extends ChangePasswordEvent {
  final String password;

  const PasswordChanged({
    required this.password,
  });
}

class PasswordConfirmationChanged extends ChangePasswordEvent {
  final String password;

  const PasswordConfirmationChanged({
    required this.password,
  });
}

class SubmitNewPasswordAction extends ChangePasswordEvent {
  const SubmitNewPasswordAction();
}
