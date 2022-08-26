import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_multi_formatter/formatters/masked_input_formatter.dart';

enum PhoneNumberCountry {
  usa,
  poland,
  belarus;

  static PhoneNumberCountry fromPhone(String? phone) {
    if (phone == null) return PhoneNumberCountry.usa;
    if (phone.contains('+1')) return PhoneNumberCountry.usa;
    if (phone.contains('+48')) return PhoneNumberCountry.poland;
    if (phone.contains('+375')) return PhoneNumberCountry.belarus;

    return PhoneNumberCountry.usa;
  }
}

class PhoneNumberFormatter {
  static final MaskedInputFormatter _usaReadOnlyFormatter =
      MaskedInputFormatter('+# ###-###-####');
  static final MaskedInputFormatter _polandReadOnlyFormatter =
      MaskedInputFormatter('+## ###-###-###');
  static final MaskedInputFormatter _belarusReadOnlyFormatter =
      MaskedInputFormatter('+### (##) ###-##-##');

  static List<TextInputFormatter> get phoneInputFormatters {
    if (kDebugMode) {
      return <TextInputFormatter>[];
    } else {
      return <TextInputFormatter>[
        MaskedInputFormatter('### ### ####'),
      ];
    }
  }

  static List<TextInputFormatter> phoneReadOnlyFormatters([String? phone]) {
    final PhoneNumberCountry phoneNumberCountry =
        PhoneNumberCountry.fromPhone(phone);

    final MaskedInputFormatter formatter;
    switch (phoneNumberCountry) {
      case PhoneNumberCountry.usa:
        formatter = _usaReadOnlyFormatter;
        break;
      case PhoneNumberCountry.poland:
        formatter = _polandReadOnlyFormatter;
        break;
      case PhoneNumberCountry.belarus:
        formatter = _belarusReadOnlyFormatter;
        break;
    }

    return <TextInputFormatter>[
      formatter,
    ];
  }
}
