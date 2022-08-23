class LoginData {
  final bool Function(String) validator;
  final bool isValidationEnabled;
  final bool hasError;
  final String login;

  bool get isValid => validator(login);

  bool get isInvalid => isValidationEnabled ? !isValid : false;

  const LoginData({
    required this.validator,
    this.isValidationEnabled = false,
    this.hasError = false,
    this.login = '',
  });

  LoginData copyWith({
    String? login,
    bool? isValidationEnabled,
    bool? hasError,
  }) {
    return LoginData(
      validator: validator,
      isValidationEnabled: isValidationEnabled ?? false,
      hasError: hasError ?? false,
      login: login ?? this.login,
    );
  }
}
