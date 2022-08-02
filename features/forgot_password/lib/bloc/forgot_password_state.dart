import 'package:domain/models/password_validator.dart';

class ForgotPasswordState {
  final PasswordValidator? passwordErrors;
  final Map<String, String>? postValidationErrors;
  final PasswordValidator? confirmedPasswordErrors;

  ForgotPasswordState({
    this.passwordErrors,
    this.postValidationErrors,
    this.confirmedPasswordErrors,
  });

  ForgotPasswordState copyWith({
    final PasswordValidator? newPasswordErrors,
    final PasswordValidator? newConfirmedPasswordErrors,
    final Map<String, String>? newPostValidationsErrors,
  }) {
    return ForgotPasswordState(
      passwordErrors: newPasswordErrors ?? passwordErrors,
      confirmedPasswordErrors:
          newConfirmedPasswordErrors ?? confirmedPasswordErrors,
      postValidationErrors: newPostValidationsErrors ?? postValidationErrors,
    );
  }

  bool get isValidationsPassed {
    return passwordErrors != null &&
        passwordErrors!.isValidationsPassed &&
        confirmedPasswordErrors != null &&
        passwordErrors!.isValidationsPassed;
  }
}
