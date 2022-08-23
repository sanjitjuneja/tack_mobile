import 'package:core/core.dart';

class PasswordValidator {
  final bool isLengthValid;
  final bool isPasswordsMatch;
  final bool isContainCapital;
  final bool isContainNumeric;
  final bool isValidationStarted;

  PasswordValidator._({
    required this.isLengthValid,
    required this.isContainCapital,
    required this.isContainNumeric,
    this.isPasswordsMatch = false,
    this.isValidationStarted = false,
  });

  factory PasswordValidator.initial() {
    return PasswordValidator._(
      isLengthValid: false,
      isPasswordsMatch: false,
      isContainCapital: false,
      isContainNumeric: false,
      isValidationStarted: false,
    );
  }

  factory PasswordValidator.validate({
    required String password,
    required String passwordConfirmation,
  }) {
    final bool isLengthValid = FieldValidator.isPasswordLengthValid(password);
    final bool isContainCapital =
        FieldValidator.isContainCapitalLetter(password);
    final bool isContainNumeric = FieldValidator.isContainsNumeric(password);
    final bool isPasswordsMatch = password == passwordConfirmation;

    return PasswordValidator._(
      isLengthValid: isLengthValid,
      isContainCapital: isContainCapital,
      isContainNumeric: isContainNumeric,
      isPasswordsMatch: isPasswordsMatch,
      isValidationStarted: password.isNotEmpty,
    );
  }

  bool get isValidationsPassed =>
      isLengthValid && isContainCapital && isContainNumeric;
}
