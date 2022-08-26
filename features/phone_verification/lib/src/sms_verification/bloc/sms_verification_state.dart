part of 'sms_verification_bloc.dart';

class SmsVerificationState {
  final PhoneVerificationData phoneVerificationData;
  final SmsCodeData codeData;

  bool get isReadyToProceed => codeData.isValid;

  const SmsVerificationState({
    required this.phoneVerificationData,
    required this.codeData,
  });

  SmsVerificationState copyWith({
    PhoneVerificationData? phoneVerificationData,
    String? code,
  }) {
    return SmsVerificationState(
      phoneVerificationData:
          phoneVerificationData ?? this.phoneVerificationData,
      codeData: codeData.copyWith(code: code),
    );
  }
}
