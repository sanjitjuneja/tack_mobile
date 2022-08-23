import 'package:core/core.dart';

class EmailData {
  final bool isValidationEnabled;
  final bool isEmailAlreadyUsed;
  final String email;

  /// Used for Business Logic
  bool get isValid => FieldValidator.isEmailValid(email);

  /// Used for UI
  bool get isInvalid =>
      isEmailAlreadyUsed || (isValidationEnabled ? !isValid : false);

  const EmailData({
    this.isValidationEnabled = false,
    this.isEmailAlreadyUsed = false,
    String? email,
  }) : email = email ?? '';

  EmailData copyWith({
    String? email,
    bool? isValidationEnabled,
    bool? isEmailAlreadyUsed,
  }) {
    return EmailData(
      isValidationEnabled: isValidationEnabled ?? false,
      isEmailAlreadyUsed: isEmailAlreadyUsed ?? false,
      email: email ?? this.email,
    );
  }
}

extension EmailViewError on EmailData {
  String? get errorKey {
    if (email.isEmpty) {
      return 'validationErrors.fieldRequired';
    } else if (isEmailAlreadyUsed) {
      return 'validationErrors.emailAlreadyInUse';
    } else if (isInvalid) {
      return 'validationErrors.emailInvalid';
    }
    return null;
  }
}
