part of authorization;

class RequestSmsCodePayload {
  final String phoneNumber;
  final PhoneVerificationType phoneVerificationType;

  RequestSmsCodePayload({
    required this.phoneNumber,
    required this.phoneVerificationType,
  });
}
