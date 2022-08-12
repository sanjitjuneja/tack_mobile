import 'package:flutter/services.dart';

class CurrencyFormatter implements TextInputFormatter {
  final double? maxValue;
  final String leadingSymbol;

  const CurrencyFormatter({
    this.maxValue,
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
      final double value = double.parse(removeFormat(newText));

      if (maxValue != null && value > maxValue!) {
        final String text = '$leadingSymbol$maxValue';

        return newValue.copyWith(
          text: text,
          selection: TextSelection.collapsed(
            offset: newValue.selection.baseOffset > text.length
                ? text.length
                : newValue.selection.baseOffset,
          ),
        );
      }

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

  String removeFormat(String text) {
    return text.replaceAll(leadingSymbol, '').replaceAll(',', '.');
  }
}
