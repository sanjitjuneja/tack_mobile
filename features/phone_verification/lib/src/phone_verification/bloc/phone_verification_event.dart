part of 'phone_verification_bloc.dart';

abstract class PhoneVerificationEvent {
  const PhoneVerificationEvent();
}

class PhoneNumberChanged extends PhoneVerificationEvent {
  final String phoneNumber;

  const PhoneNumberChanged(
    this.phoneNumber,
  );
}

class VerifyAction extends PhoneVerificationEvent {
  const VerifyAction();
}
