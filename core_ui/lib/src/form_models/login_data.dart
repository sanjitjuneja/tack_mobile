part of form_models;

class LoginData {
  final bool isValidationEnabled;
  final bool hasError;
  final String login;

  bool get isValid => FieldValidator.validateLogin(login);

  bool get isInvalid => isValidationEnabled ? !isValid : false;

  const LoginData({
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
      isValidationEnabled: isValidationEnabled ?? false,
      hasError: hasError ?? false,
      login: login ?? this.login,
    );
  }
}
