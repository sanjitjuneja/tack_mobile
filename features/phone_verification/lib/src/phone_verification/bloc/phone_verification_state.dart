part of 'phone_verification_bloc.dart';

class PhoneVerificationState {
  final PhoneVerificationType phoneVerificationType;
  final PhoneData phoneData;

  bool get isReadyToProceed => phoneData.isValid;

  const PhoneVerificationState({
    required this.phoneVerificationType,
    required this.phoneData,
  });

  PhoneVerificationState copyWith({
    String? phone,
  }) {
    return PhoneVerificationState(
      phoneVerificationType: phoneVerificationType,
      phoneData: phoneData.copyWith(phone: phone),
    );
  }
}
