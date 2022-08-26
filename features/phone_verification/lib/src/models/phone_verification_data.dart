import 'phone_verification_type.dart';

class PhoneVerificationData {
  final PhoneVerificationType verificationType;
  final String udid;
  final String phoneNumber;

  PhoneVerificationData({
    required this.verificationType,
    required this.udid,
    required this.phoneNumber,
  });
}
