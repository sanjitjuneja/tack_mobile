part of phone_verification;

class VerifyPhoneNumberPayload {
  final String uuid;
  final String smsCode;

  VerifyPhoneNumberPayload({
    required this.uuid,
    required this.smsCode,
  });
}
