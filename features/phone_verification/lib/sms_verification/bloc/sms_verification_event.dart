abstract class SmsVerificationEvent {}

class RouteBack extends SmsVerificationEvent {}

class RequestVerificationCode extends SmsVerificationEvent {}

class VerifyNumber extends SmsVerificationEvent {
  final String verificationCode;

  VerifyNumber({
    required this.verificationCode,
  });
}
