import 'package:flutter/foundation.dart';

class FieldValidator {
  static const int _passwordMinLength = 8;
  static const int _passwordMaxLength = 16;

  static const String _phoneNumberPattern = r'^\+?[0-9]{10,12}$';
  static const String _emailPattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  static const String _digitsPattern = r'^\+?\d+$';

  static const String _containCapitalPattern = r'.*[A-Z].*';
  static const String _containNumericPattern = r'.*\d.*';

  static const String _phoneNumberPrefix = '+';
  static const String _americanPhoneNumberPrefix = '${_phoneNumberPrefix}1';
  static const int _americanPhoneNumberLength = 10;

  static String adjustToAmericanNumberIfNeeded(String data) {
    final String login = data.replaceAll(RegExp(r'\s+'), '');

    if (kDebugMode) {
      if (isPhoneNumber(login)) {
        return '+$login';
      } else {
        return login;
      }
    }

    if (validatePhoneNumber(login)) {
      if (login.length == _americanPhoneNumberLength) {
        return '$_americanPhoneNumberPrefix$login';
      } else if (!login.contains(_phoneNumberPrefix)) {
        return '$_phoneNumberPrefix$login';
      }
    }

    return login;
  }

  static bool validateLogin(String login) {
    if (login.isEmpty) return false;

    final bool isNumber = isPhoneNumber(login);
    if (isNumber) {
      if (!isPhoneNumberValid(login)) return false;
    } else {
      return isEmailValid(login);
    }

    return true;
  }

  static bool validatePhoneNumber(String phoneNumber) {
    final String number = phoneNumber.replaceAll(RegExp(r'\s+'), '');

    return isPhoneNumberValid(number);
  }

  static bool isPhoneNumber(String data) {
    return _regexValidator(
      regexPattern: _digitsPattern,
      value: data,
    );
  }

  static bool isPhoneNumberValid(String phoneNumber) {
    return _regexValidator(
      regexPattern: _phoneNumberPattern,
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

  static bool isEmailValid(String email) {
    return _regexValidator(
      regexPattern: _emailPattern,
      value: email,
    );
  }

  static bool isPasswordLengthValid(String data) {
    return data.length >= _passwordMinLength &&
        data.length <= _passwordMaxLength;
  }

  static bool isContainCapitalLetter(String data) {
    return _regexValidator(
      regexPattern: _containCapitalPattern,
      value: data,
    );
  }

  static bool isContainsNumeric(String data) {
    return _regexValidator(
      regexPattern: _containNumericPattern,
      value: data,
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
