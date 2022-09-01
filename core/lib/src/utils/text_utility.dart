import 'package:flutter/cupertino.dart';

class TextUtility {
  static RegExp get wordsLengthRegExp => RegExp(r'[\w-]+');

  static int getWordsCount(String? source) {
    /// only working with english language, russian is not supported.
    if (source == null) return 0;

    return wordsLengthRegExp.allMatches(source).length;
  }

  static Size getTextSize(
    String content, {
    TextStyle? textStyle,
  }) {
    TextPainter textPainter = TextPainter(
      text: TextSpan(text: content, style: textStyle),
      textDirection: TextDirection.ltr,
    );
    textPainter.layout();

    return textPainter.size;
  }
}

extension PrepareForEllipsis on String {
  String get toElliptical => replaceAll('', '\u{200B}');
}

extension StringToSentenceCase on String {
  String toSentenceCase() {
    return '${this[0].toUpperCase()}${substring(1).toLowerCase()}';
  }
}
