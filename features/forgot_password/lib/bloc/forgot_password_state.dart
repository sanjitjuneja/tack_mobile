import 'package:domain/models/base_error_model.dart';

class ForgotPasswordState {
  final List<BaseErrorModel>? passwordErrors;
  final Map<String, String>? postValidationErrors;
  final List<BaseErrorModel>? confirmedPasswordErrors;

  ForgotPasswordState({
    this.passwordErrors,
    this.postValidationErrors,
    this.confirmedPasswordErrors,
  });

  ForgotPasswordState copyWith({
    final List<BaseErrorModel>? newPasswordErrors,
    final List<BaseErrorModel>? newConfirmedPasswordErrors,
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
        passwordErrors!.isEmpty &&
        confirmedPasswordErrors != null &&
        passwordErrors!.isEmpty;
  }
}
