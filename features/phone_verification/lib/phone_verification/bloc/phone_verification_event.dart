abstract class PhoneVerificationEvent {}

class RouteBack extends PhoneVerificationEvent {}

class UpdateData extends PhoneVerificationEvent {
  final String phoneNumber;

  UpdateData({
    required this.phoneNumber,
  });
}

class VerifyPhoneNumber extends PhoneVerificationEvent {
  final String phoneNumber;

  VerifyPhoneNumber({
    required this.phoneNumber,
  });
}
