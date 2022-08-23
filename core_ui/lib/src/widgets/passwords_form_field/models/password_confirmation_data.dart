part of passwords_form_field;

class PasswordConfirmationData {
  final bool Function(String) validator;
  final bool isValidationEnabled;
  final String password;

  bool get isValid => validator(password);

  bool get isInvalid => isValidationEnabled ? !isValid : false;

  const PasswordConfirmationData({
    required this.validator,
    this.isValidationEnabled = false,
    this.password = '',
  });

  PasswordConfirmationData copyWith({
    String? password,
    bool? isValidationEnabled,
    bool? hasError,
  }) {
    return PasswordConfirmationData(
      validator: validator,
      isValidationEnabled: isValidationEnabled ?? false,
      password: password ?? this.password,
    );
  }
}
