import 'phone_verification_data.dart';

class PhoneVerificationScreenResult {
  final PhoneVerificationData? phoneVerificationData;
  final bool shouldOpenSignIn;
  final bool shouldOpenSignUp;

  const PhoneVerificationScreenResult({
    this.phoneVerificationData,
    this.shouldOpenSignIn = false,
    this.shouldOpenSignUp = false,
  });
}
