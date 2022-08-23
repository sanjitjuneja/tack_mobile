part of passwords_form_field;

class PasswordData {
  final bool Function(String) validator;
  final bool isValidationEnabled;
  final String password;

  bool get isValid => validator(password);

  bool get isInvalid => isValidationEnabled ? !isValid : false;

  const PasswordData({
    required this.validator,
    this.isValidationEnabled = false,
    this.password = '',
  });

  PasswordData copyWith({
    String? password,
    bool? isValidationEnabled,
    bool? hasError,
  }) {
    return PasswordData(
      validator: validator,
      isValidationEnabled: isValidationEnabled ?? false,
      password: password ?? this.password,
    );
  }
}
