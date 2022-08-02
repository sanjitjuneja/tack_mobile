import 'package:domain/models/password_validator.dart';

class PersonalInformationState {
  final bool? isTermsAccepted;
  final PasswordValidator passwordError;
  final PasswordValidator confirmedPasswordError;
  final Map<String, String>? postValidationErrors;

  PersonalInformationState({
    required this.passwordError,
    required this.confirmedPasswordError,
    this.isTermsAccepted,
    this.postValidationErrors,
  });

  PersonalInformationState copyWith({
    final bool? isNewTermsAccepted,
    final PasswordValidator? newPasswordError,
    final PasswordValidator? newConfirmedPasswordError,
    final Map<String, String>? newPostValidationErrors,
  }) {
    return PersonalInformationState(
      isTermsAccepted: isNewTermsAccepted ?? isTermsAccepted,
      passwordError: newPasswordError ?? passwordError,
      confirmedPasswordError:
          newConfirmedPasswordError ?? confirmedPasswordError,
      postValidationErrors: newPostValidationErrors ?? postValidationErrors,
    );
  }

  bool get isValidationsPassed {
    return isTermsAccepted != null &&
        isTermsAccepted! == true &&
        passwordError.isValidationsPassed &&
        confirmedPasswordError.isValidationsPassed;
  }
}
