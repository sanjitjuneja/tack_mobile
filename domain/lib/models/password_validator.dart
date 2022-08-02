class PasswordValidator {
  final bool isLengthValid;
  final bool isPasswordsMatch;
  final bool isContainCapital;
  final bool isContainNumeric;
  final bool isValidationStarted;

  PasswordValidator({
    required this.isLengthValid,
    required this.isContainCapital,
    required this.isContainNumeric,
    this.isPasswordsMatch = false,
    this.isValidationStarted = false,
  });

  factory PasswordValidator.initial() {
    return PasswordValidator(
      isLengthValid: false,
      isPasswordsMatch: false,
      isContainCapital: false,
      isContainNumeric: false,
      isValidationStarted: false,
    );
  }

  bool get isValidationsPassed =>
      isLengthValid && isContainCapital && isContainNumeric;
}
