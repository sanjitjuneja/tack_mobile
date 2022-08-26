part of authorization;

class VerifyPhoneNumberPayload {
  final String uuid;
  final String smsCode;

  const VerifyPhoneNumberPayload({
    required this.uuid,
    required this.smsCode,
  });
}
