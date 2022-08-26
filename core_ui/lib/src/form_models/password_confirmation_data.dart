part of form_models;

class PasswordConfirmationData {
  final bool isValidationEnabled;
  final String password;

  bool get isValid => FieldValidator.isPasswordLengthValid(password);

  bool get isInvalid => isValidationEnabled ? !isValid : false;

  const PasswordConfirmationData({
    this.isValidationEnabled = false,
    this.password = '',
  });

  PasswordConfirmationData copyWith({
    String? password,
    bool? isValidationEnabled,
  }) {
    return PasswordConfirmationData(
      isValidationEnabled: isValidationEnabled ?? false,
      password: password ?? this.password,
    );
  }
}
