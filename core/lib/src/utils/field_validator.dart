import 'package:core/src/utils/regular_expressions.dart';
import 'package:domain/models/base_error_model.dart';

String phoneNumberPattern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
String _namePattern =
    r'''^(?=[a-zA-Z0-9._]{3,100}$)(?!.*[_.]{2})[^_.].*[^_.]$''';
String containCapitalPattern =
    r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
String containNumberPattern = '/\d/';

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

  static bool isContainsNumeric(String str) {
    final RegExp regExp = RegExp(r'[0-9]');
    return str.contains(regExp);
  }

  static bool isContainCapitalLetter(String str) {
    final RegExp regExp = RegExp(containCapitalPattern);
    return capitalLetterRegEx.hasMatch(str);
  }

  static List<BaseErrorModel> getPasswordValidationsList(String password) {
    final List<BaseErrorModel> validations = <BaseErrorModel>[];
    if (password.length < 8 || password.length > 16) {
      validations.add(
        BaseErrorModel(
          errorText: '8-16 characters',
          descriptionText: '(E.g: Ab12345678 )',
        ),
      );
    }

    if (!FieldValidator.isContainCapitalLetter(password)) {
      validations.add(
        BaseErrorModel(
          errorText: 'At least 1 Capital Letter',
          descriptionText: '(E.g: ABCD )',
        ),
      );
    }

    if (!FieldValidator.isContainsNumeric(password)) {
      validations.add(
        BaseErrorModel(
          errorText: 'At least 1 Digit (E.g: 12345)',
          descriptionText: '(E.g: 12345)',
        ),
      );
    }

    return validations;
  }

  static List<BaseErrorModel> getNameValidationsList(String name) {
    final List<BaseErrorModel> validations = <BaseErrorModel>[];
    if (name.isEmpty) {
      validations.add(
        BaseErrorModel(
          errorText: 'This field should be not empty',
        ),
      );
    }

    if (name.length < 5 || name.length > 15) {
      validations.add(
        BaseErrorModel(
          errorText: '5 - 15 characters',
        ),
      );
    }

    return validations;
  }
}
