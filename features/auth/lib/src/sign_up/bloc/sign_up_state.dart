part of 'sign_up_bloc.dart';

class SignUpState {
  final PhoneVerificationData phoneVerificationData;
  final FirstNameData firstNameData;
  final LastNameData lastNameData;
  final EmailData emailData;
  final TermsData termsData;
  final PasswordData passwordData;
  final PasswordConfirmationData passwordConfirmationData;
  final PasswordValidator passwordsValidator;

  bool get isReadyToProceed {
    return <bool>[
      firstNameData.isValid,
      lastNameData.isValid,
      emailData.isValid,
      termsData.isValid,
      passwordsValidator.isValidationsPassed,
    ].every((bool element) => element == true);
  }

  SignUpState({
    required this.phoneVerificationData,
    required this.firstNameData,
    required this.lastNameData,
    required this.emailData,
    required this.termsData,
    required this.passwordData,
    required this.passwordConfirmationData,
    required this.passwordsValidator,
  });

  SignUpState copyWith({
    String? firstName,
    String? lastName,
    String? email,
    bool? isTermsAccepted,
    String? password,
    String? passwordConfirmation,
    bool? isValidationEnabled,
    bool? isEmailAlreadyUsed,
    PasswordValidator? passwordsValidator,
  }) {
    return SignUpState(
      phoneVerificationData: phoneVerificationData,
      firstNameData: firstNameData.copyWith(
        firstName: firstName,
        isValidationEnabled: isValidationEnabled,
      ),
      lastNameData: lastNameData.copyWith(
        lastName: lastName,
        isValidationEnabled: isValidationEnabled,
      ),
      emailData: emailData.copyWith(
        email: email,
        isValidationEnabled: isValidationEnabled,
        isEmailAlreadyUsed: isEmailAlreadyUsed,
      ),
      termsData: termsData.copyWith(
        isAccepted: isTermsAccepted,
        isValidationEnabled: isValidationEnabled,
      ),
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
