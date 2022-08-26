import 'package:core/core.dart';

class PasswordValidator {
  final bool isLengthValid;
  final bool isContainCapital;
  final bool isContainNumeric;
  final bool isPasswordsMatch;
  final bool isNewAndOldIdentical;
  final bool isValidationStarted;

  PasswordValidator._({
    required this.isLengthValid,
    required this.isContainCapital,
    required this.isContainNumeric,
    this.isPasswordsMatch = false,
    this.isNewAndOldIdentical = false,
    this.isValidationStarted = false,
  });

  factory PasswordValidator.initial() {
    return PasswordValidator._(
      isLengthValid: false,
      isContainCapital: false,
      isContainNumeric: false,
      isPasswordsMatch: false,
      isNewAndOldIdentical: false,
      isValidationStarted: false,
    );
  }

  factory PasswordValidator.validate({
    required String password,
    required String passwordConfirmation,
    String? oldPassword,
  }) {
    final bool isLengthValid = FieldValidator.isPasswordLengthValid(password);
    final bool isContainCapital =
        FieldValidator.isContainCapitalLetter(password);
    final bool isContainNumeric = FieldValidator.isContainsNumeric(password);
    final bool isPasswordsMatch = password == passwordConfirmation;
    final bool isNewAndOldIdentical = password == oldPassword;

    return PasswordValidator._(
      isLengthValid: isLengthValid,
      isContainCapital: isContainCapital,
      isContainNumeric: isContainNumeric,
      isPasswordsMatch: isPasswordsMatch,
      isNewAndOldIdentical: isNewAndOldIdentical,
      isValidationStarted: password.isNotEmpty,
    );
  }

  bool get isValidationsPassed {
    return <bool>[
      isLengthValid,
      isContainCapital,
      isContainNumeric,
      isPasswordsMatch,
      !isNewAndOldIdentical,
    ].every((element) => element == true);
  }
}
