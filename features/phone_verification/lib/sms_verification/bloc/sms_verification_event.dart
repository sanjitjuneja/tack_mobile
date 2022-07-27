abstract class SmsVerificationEvent {}

class RouteBack extends SmsVerificationEvent {}

class UpdateData extends SmsVerificationEvent {
  final String verificationCode;

  UpdateData({
    required this.verificationCode,
  });
}

class RequestVerificationCode extends SmsVerificationEvent {}

class VerifyNumber extends SmsVerificationEvent {
  final String verificationCode;

  VerifyNumber({
    required this.verificationCode,
  });
}
