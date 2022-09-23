part of 'sms_verification_bloc.dart';

abstract class SmsVerificationEvent {
  const SmsVerificationEvent();
}

class CodeChanged extends SmsVerificationEvent {
  final String verificationCode;

  const CodeChanged({
    required this.verificationCode,
  });
}

class ResendCodeAction extends SmsVerificationEvent {
  const ResendCodeAction();
}

class ResendCodeTimerExpired extends SmsVerificationEvent {
  const ResendCodeTimerExpired();
}

class VerifyNumberAction extends SmsVerificationEvent {
  const VerifyNumberAction();
}
