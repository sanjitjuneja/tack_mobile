import 'package:core/src/utils/regular_expressions.dart';
import 'package:domain/models/base_error_model.dart';

String phoneNumberPattern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
String _namePattern =
    r'''^(?=[a-zA-Z0-9._]{3,100}$)(?!.*[_.]{2})[^_.].*[^_.]$''';
String containCapitalPattern =
    r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
String containNumberPattern = '/\d/';
String _emailPattern =
    r'''(?:[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*|"(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21\x23-\x5b\x5d-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])*")@(?:(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\[(?:(?:(2(5[0-5]|[0-4][0-9])|1[0-9][0-9]|[1-9]?[0-9]))\.){3}(?:(2(5[0-5]|[0-4][0-9])|1[0-9][0-9]|[1-9]?[0-9])|[a-z0-9-]*[a-z0-9]:(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21-\x5a\x53-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])+)\])''';

class FieldValidator {
  static bool validatePhoneNumber(String phoneNumber) {
    const int phoneNumberLength = 11;
    final number = phoneNumber.replaceAll(RegExp(r"\s+"), "");

    if (number.isEmpty) {
      return false;
    } else if (number.length != phoneNumberLength) {
      return false;
    } else if (!isPhoneNumberValid(number)) {
      return false;
    } else {
      return true;
    }
  }

  static bool isPhoneNumberValid(String phoneNumber) {
    return _regexValidator(
      regexPattern: phoneNumberPattern,
      value: phoneNumber,
    );
  }

  static bool _regexValidator({
    required String regexPattern,
    required String value,
  }) {
    final Iterable<RegExpMatch> matches =
        RegExp(regexPattern).allMatches(value);
    return matches.length == 1;
  }

  static bool validatePassword(String password) {
    const int passwordMinLength = 8;
    const int passwordMaxLength = 16;

    if (password.length >= passwordMinLength &&
        password.length <= passwordMaxLength) {
      return true;
    } else {
      return false;
    }
  }

  static bool isEmailValid(String email) {
    return _regexValidator(
      regexPattern: _emailPattern,
      value: email,
    );
  }

  static bool isContainsNumeric(String str) {
    final RegExp regExp = RegExp(r'[0-9]');
    return str.contains(regExp);
  }

  static bool isContainCapitalLetter(String str) {
    return capitalLetterRegEx.hasMatch(str);
  }

  static PasswordValidator getPasswordValidationsList({
    required String password,
    required String confirmedPassword,
  }) {
    bool isLengthValid = false;
    bool isContainCapital = false;
    bool isContainNumeric = false;
    bool isPasswordsMatch = false;

    if (password.length > 8 || password.length < 16) {
      isLengthValid = true;
    }

    if (FieldValidator.isContainCapitalLetter(password)) {
      isContainCapital = true;
    }

    if (FieldValidator.isContainsNumeric(password)) {
      isContainNumeric = true;
    }

    if (password == confirmedPassword) {
      isPasswordsMatch = true;
    }

    return PasswordValidator(
      isLengthValid: isLengthValid,
      isContainCapital: isContainCapital,
      isContainNumeric: isContainNumeric,
      isValidationStarted: true,
      isPasswordsMatch: isPasswordsMatch,
    );
  }

  static String? validateEmail(String email) {
    if (!isEmailValid(email)) {
      return 'Email format is not valid';
    } else {
      return null;
    }
  }
}
