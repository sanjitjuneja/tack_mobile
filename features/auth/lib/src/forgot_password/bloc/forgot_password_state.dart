part of 'forgot_password_bloc.dart';

class ForgotPasswordState {
  final PhoneVerificationData phoneVerificationData;
  final PasswordData passwordData;
  final PasswordConfirmationData passwordConfirmationData;
  final PasswordValidator passwordsValidator;

  bool get isReadyToProceed {
    return passwordData.isValid &&
        passwordConfirmationData.isValid &&
        passwordsValidator.isValidationsPassed;
  }

  ForgotPasswordState({
    required this.phoneVerificationData,
    required this.passwordData,
    required this.passwordConfirmationData,
    required this.passwordsValidator,
  });

  ForgotPasswordState copyWith({
    String? password,
    String? passwordConfirmation,
    bool? isValidationEnabled,
    PasswordValidator? passwordsValidator,
  }) {
    return ForgotPasswordState(
      phoneVerificationData: phoneVerificationData,
      passwordData: passwordData.copyWith(
        password: password,
        isValidationEnabled: isValidationEnabled,
      ),
      passwordConfirmationData: passwordConfirmationData.copyWith(
        password: passwordConfirmation,
        isValidationEnabled: isValidationEnabled,
      ),
      passwordsValidator: passwordsValidator ?? this.passwordsValidator,
    );
  }
}
