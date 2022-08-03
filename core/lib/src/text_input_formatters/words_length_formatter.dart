import 'package:core/core.dart';
import 'package:flutter/services.dart';

class WordsLengthFormatter implements TextInputFormatter {
  final int? maxWordsLength;

  const WordsLengthFormatter([
    this.maxWordsLength,
  ]);

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if (maxWordsLength == null) return newValue;

    final int wordsCount = TextUtility.getWordsCount(newValue.text);

    if (wordsCount > maxWordsLength!) return oldValue;

    return newValue;
  }
}
