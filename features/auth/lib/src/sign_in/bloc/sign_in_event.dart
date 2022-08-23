part of 'sign_in_bloc.dart';

abstract class SignInEvent {
  const SignInEvent();
}

class LoginChanged extends SignInEvent {
  final String login;

  const LoginChanged(this.login);
}

class PasswordChanged extends SignInEvent {
  final String password;

  const PasswordChanged(this.password);
}

class SignInAction extends SignInEvent {
  const SignInAction();
}

class ForgotPasswordAction extends SignInEvent {
  const ForgotPasswordAction();
}

class SignUpAction extends SignInEvent {
  const SignUpAction();
}
