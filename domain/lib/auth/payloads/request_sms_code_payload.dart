part of phone_verification;

class RequestSmsCodePayload {
  final String phoneNumber;
  final PhoneVerificationType phoneVerificationType;

  RequestSmsCodePayload({
    required this.phoneNumber,
    required this.phoneVerificationType,
  });
}
