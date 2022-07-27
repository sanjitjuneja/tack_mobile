import 'package:flutter_multi_formatter/formatters/masked_input_formatter.dart';

class PhoneNumberFormatter {
  static final phoneInputFormatter = MaskedInputFormatter('### ### ####');

  static String getPhoneWithoutSpaces(String phoneNumber) {
    return phoneNumber.replaceAll(RegExp(r"\s+"), "");
  }
}
