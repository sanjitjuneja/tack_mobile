import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

import 'package:core/text_input_formatters/currency_formatter.dart';

class CurrencyUtility {
  static List<TextInputFormatter> dollarInputFormatters({double? maxValue}) =>
      <TextInputFormatter>[
        FilteringTextInputFormatter.allow(
          RegExp(r'^\$?\d+\.?\d{0,2}'),
        ),
        CurrencyFormatter(maxValue: maxValue),
      ];

  static NumberFormat get dollarFormat => NumberFormat.currency(
        symbol: '\$',
        decimalDigits: 2,
      );

  static NumberFormat get dollarRoundFormat => NumberFormat.currency(
        symbol: '\$',
        decimalDigits: 0,
      );
}
