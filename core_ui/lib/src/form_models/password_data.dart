part of form_models;

class PasswordData {
  final bool isValidationEnabled;
  final String password;

  bool get isValid => FieldValidator.isPasswordLengthValid(password);

  bool get isInvalid => isValidationEnabled ? !isValid : false;

  const PasswordData({
    this.isValidationEnabled = false,
    this.password = '',
  });

  PasswordData copyWith({
    String? password,
    bool? isValidationEnabled,
  }) {
    return PasswordData(
      isValidationEnabled: isValidationEnabled ?? false,
      password: password ?? this.password,
    );
  }
}
