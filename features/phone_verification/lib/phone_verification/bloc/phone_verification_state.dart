abstract class PhoneVerificationState {}

class PhoneVerificationContent extends PhoneVerificationState {
  final bool isDataValid;

  PhoneVerificationContent({
    required this.isDataValid,
  });
}
