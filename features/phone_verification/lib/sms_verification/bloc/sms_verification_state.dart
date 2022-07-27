abstract class SmsVerificationState {}

class SmsVerificationContent extends SmsVerificationState {
  final bool isDataValid;

  SmsVerificationContent({
    required this.isDataValid,
  });
}
