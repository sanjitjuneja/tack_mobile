import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class CurrencyUtility {
  static List<TextInputFormatter> get dollarInputFormatters =>
      <TextInputFormatter>[
        FilteringTextInputFormatter.allow(
          RegExp(r'^\$?\d+\.?\d{0,2}'),
        ),
        const CurrencyFormatter(),
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

class CurrencyFormatter implements TextInputFormatter {
  final String leadingSymbol;

  const CurrencyFormatter({
    this.leadingSymbol = '\$',
  });

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final String text = newValue.text;
    if (text.isEmpty) {
      return newValue.copyWith(
        selection: TextSelection.collapsed(
          offset: text.length,
        ),
        text: '',
      );
    } else {
      final bool isContainsSymbol = text.contains(leadingSymbol);
      final String newText = isContainsSymbol ? text : '$leadingSymbol$text';

      return newValue.copyWith(
        selection: TextSelection.collapsed(
          offset: isContainsSymbol
              ? newValue.selection.baseOffset
              : newValue.selection.baseOffset + 1,
        ),
        text: newText,
      );
    }
  }
}
