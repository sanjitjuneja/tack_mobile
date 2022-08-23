part of 'sign_up_bloc.dart';

abstract class SignUpEvent {
  const SignUpEvent();
}

class FirstNameChanged extends SignUpEvent {
  final String firstName;

  const FirstNameChanged({
    required this.firstName,
  });
}

class LastNameChanged extends SignUpEvent {
  final String lastName;

  const LastNameChanged({
    required this.lastName,
  });
}

class EmailChanged extends SignUpEvent {
  final String email;

  const EmailChanged({
    required this.email,
  });
}

class PasswordChanged extends SignUpEvent {
  final String password;

  const PasswordChanged({
    required this.password,
  });
}

class PasswordConfirmationChanged extends SignUpEvent {
  final String password;

  const PasswordConfirmationChanged({
    required this.password,
  });
}

class TermsAndConditionsChanged extends SignUpEvent {
  final bool isAccepted;

  const TermsAndConditionsChanged({
    required this.isAccepted,
  });
}

class RegisterUserAction extends SignUpEvent {
  const RegisterUserAction();
}
