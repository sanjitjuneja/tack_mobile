import 'package:core/utils/regular_expressions.dart';

String phoneNumberPattern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
String _namePattern =
    r'''^(?=[a-zA-Z0-9._]{3,100}$)(?!.*[_.]{2})[^_.].*[^_.]$''';

class FieldValidator {
  static bool validatePhoneNumber(String phoneNumber) {
    const int phoneNumberLength = 10;
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
    const int passwordMinLength = 16;
    const int passwordMaxLength = 50;

    if (password.length >= passwordMinLength &&
        password.length <= passwordMaxLength) {
      return true;
    } else {
      return false;
    }
  }

  bool isNameFormatValid(String name) {
    return _regexValidator(
      value: name,
      regexPattern: _namePattern,
    );
  }

  static String? getPasswordValidations(String password) {
    if (password.length < 8 || password.length > 16) {
      return '8-16 characters (E.g: Ab12345678 )';
    } else if (!isContainCapitalLetter(password)) {
      return 'At least 1 Capital Letter(E.g: ABCD )';
    } else if (!isContainsNumeric(password)) {
      return 'At least 1 Digit (E.g: 12345 )';
    } else {
      return null;
    }
  }

  static bool isContainsNumeric(String str) {
    return numericRegEx.hasMatch(str);
  }

  static bool isContainCapitalLetter(String str) {
    return capitalLetterRegEx.hasMatch(str);
  }
}
