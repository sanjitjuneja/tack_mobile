import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_multi_formatter/formatters/masked_input_formatter.dart';

class PhoneNumberFormatter {
  static List<TextInputFormatter> get phoneInputFormatters {
    if (kDebugMode) {
      return <TextInputFormatter>[];
    } else {
      return <TextInputFormatter>[
        MaskedInputFormatter('### ### ####'),
      ];
    }
  }

  static String getPhoneWithoutSpaces(String phoneNumber) {
    return phoneNumber.replaceAll(RegExp(r"\s+"), "");
  }
}
