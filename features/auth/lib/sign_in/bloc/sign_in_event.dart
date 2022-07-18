abstract class SignInEvent {}

class SignIn extends SignInEvent {
  final String password;
  final String phoneNumber;

  SignIn({
    required this.password,
    required this.phoneNumber,
  });
}

class RouteBack extends SignInEvent {}

class UpdateData extends SignInEvent {
  final String password;
  final String phoneNumber;

  UpdateData({
    required this.password,
    required this.phoneNumber,
  });
}

class RouteToForgotPassword extends SignInEvent {}
