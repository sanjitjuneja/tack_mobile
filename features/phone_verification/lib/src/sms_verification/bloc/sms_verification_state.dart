part of 'sms_verification_bloc.dart';

class SmsVerificationState {
  final PhoneVerificationData phoneVerificationData;
  final SmsCodeData codeData;
  final DateTime? nextCodeResendAvailableTime;

  bool get canResendCode => nextCodeResendAvailableTime == null;

  bool get isReadyToProceed => codeData.isValid;

  const SmsVerificationState({
    required this.phoneVerificationData,
    required this.codeData,
    this.nextCodeResendAvailableTime,
  });

  SmsVerificationState copyWith({
    PhoneVerificationData? phoneVerificationData,
    String? code,
    Optional<DateTime?>? nextCodeResendAvailableTime,
  }) {
    return SmsVerificationState(
      phoneVerificationData:
          phoneVerificationData ?? this.phoneVerificationData,
      codeData: codeData.copyWith(code: code),
      nextCodeResendAvailableTime: nextCodeResendAvailableTime == null
          ? this.nextCodeResendAvailableTime
          : nextCodeResendAvailableTime.value,
    );
  }
}
