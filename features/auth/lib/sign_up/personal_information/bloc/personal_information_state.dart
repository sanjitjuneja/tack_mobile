import 'package:domain/models/base_error_model.dart';

class PersonalInformationState {
  final bool? isTermsAccepted;
  final List<BaseErrorModel>? firstNameError;
  final List<BaseErrorModel>? passwordError;
  final List<BaseErrorModel>? secondNameError;
  final List<BaseErrorModel>? confirmedPasswordError;
  final Map<String, String>? postValidationErrors;

  PersonalInformationState({
    this.firstNameError,
    this.passwordError,
    this.isTermsAccepted,
    this.secondNameError,
    this.confirmedPasswordError,
    this.postValidationErrors,
  });

  PersonalInformationState copyWith({
    final bool? isNewTermsAccepted,
    final List<BaseErrorModel>? newFirstNameError,
    final List<BaseErrorModel>? newPasswordError,
    final List<BaseErrorModel>? newSecondNameError,
    final List<BaseErrorModel>? newConfirmedPasswordError,
    final Map<String, String>? newPostValidationErrors,
  }) {
    return PersonalInformationState(
      isTermsAccepted: isNewTermsAccepted ?? isTermsAccepted,
      firstNameError: newFirstNameError ?? firstNameError,
      secondNameError: newSecondNameError ?? secondNameError,
      passwordError: newPasswordError ?? passwordError,
      confirmedPasswordError:
          newConfirmedPasswordError ?? confirmedPasswordError,
      postValidationErrors: newPostValidationErrors ?? postValidationErrors,
    );
  }

  bool get isValidationsPassed {
    return isTermsAccepted != null &&
        isTermsAccepted! == true &&
        firstNameError != null &&
        firstNameError!.isEmpty &&
        passwordError != null &&
        passwordError!.isEmpty &&
        secondNameError != null &&
        secondNameError!.isEmpty &&
        confirmedPasswordError != null &&
        confirmedPasswordError!.isEmpty;
  }
}
