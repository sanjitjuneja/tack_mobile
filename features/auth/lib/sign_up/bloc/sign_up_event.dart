abstract class SignUpEvent {}

class SignUp extends SignUpEvent {
  final String phoneNumber;

  SignUp({
    required this.phoneNumber,
  });
}

class VerifyPhoneNumber extends SignUpEvent {}

class RouteBack extends SignUpEvent {}
