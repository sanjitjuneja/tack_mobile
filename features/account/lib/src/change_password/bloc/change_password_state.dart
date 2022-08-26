part of 'change_password_bloc.dart';

class ChangePasswordState {
  final OldPasswordData oldPasswordData;
  final PasswordData passwordData;
  final PasswordConfirmationData passwordConfirmationData;
  final PasswordValidator passwordsValidator;

  bool get isReadyToProceed {
    return oldPasswordData.isValid &&
        passwordData.isValid &&
        passwordConfirmationData.isValid &&
        passwordsValidator.isValidationsPassed;
  }

  ChangePasswordState({
    required this.oldPasswordData,
    required this.passwordData,
    required this.passwordConfirmationData,
    required this.passwordsValidator,
  });

  ChangePasswordState copyWith({
    String? oldPassword,
    String? password,
    String? passwordConfirmation,
    bool? isValidationEnabled,
    bool? isOldPasswordInvalid,
    PasswordValidator? passwordsValidator,
  }) {
    return ChangePasswordState(
      oldPasswordData: oldPasswordData.copyWith(
        password: oldPassword,
        isValidationEnabled: isValidationEnabled,
        isWrongPassword: isOldPasswordInvalid,
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
