import 'package:flutter/services.dart';

class RangeNumberFormatter extends TextInputFormatter {
  final num min;
  final num max;

  RangeNumberFormatter({
    num? min,
    num? max,
  })  : min = min ?? 0.0,
        max = max ?? 0.0;

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if (newValue.text == '') {
      return newValue;
    } else if (int.parse(newValue.text) < min) {
      return TextEditingValue.empty.copyWith(text: min.toStringAsFixed(2));
    } else {
      return int.parse(newValue.text) > max
          ? oldValue.copyWith(text: max.toString())
          : newValue;
    }
  }
}
