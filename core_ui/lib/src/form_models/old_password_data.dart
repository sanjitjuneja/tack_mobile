part of form_models;

class OldPasswordData {
  final bool isValidationEnabled;
  final bool isWrongPassword;
  final String password;

  bool get isValid => password.isNotEmpty;

  bool get isInvalid {
    return isWrongPassword || (isValidationEnabled ? !isValid : false);
  }

  const OldPasswordData({
    this.isValidationEnabled = false,
    this.isWrongPassword = false,
    this.password = '',
  });

  OldPasswordData copyWith({
    String? password,
    bool? isValidationEnabled,
    bool? isWrongPassword,
  }) {
    return OldPasswordData(
      isValidationEnabled: isValidationEnabled ?? false,
      isWrongPassword: isWrongPassword ?? false,
      password: password ?? this.password,
    );
  }
}

extension OldPasswordViewError on OldPasswordData {
  String? get errorKey {
    if (password.isEmpty) {
      return 'validationErrors.fieldRequired';
    } else if (isWrongPassword) {
      return 'validationErrors.wrongPassword';
    }

    return null;
  }
}
