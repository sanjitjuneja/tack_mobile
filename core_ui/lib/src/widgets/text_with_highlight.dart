import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

class TextWithHighlight extends StatelessWidget {
  /// Basic
  static const String _body = 'body';
  static const String _paragraph = 'p';
  static const String _link = 'a';

  /// Custom
  static const String _highlight = 'highlight';
  static const String _colored = 'colored';
  static const String _highlightColored = 'highlight-colored';

  final String text;
  final TextStyle textStyle;
  final TextAlign textAlign;
  final Color? coloredTextColor;
  final void Function(String? url)? onLinkTap;

  const TextWithHighlight({
    super.key,
    required this.text,
    TextStyle? textStyle,
    this.textAlign = TextAlign.start,
    this.coloredTextColor,
    this.onLinkTap,
  }) : textStyle = textStyle ?? const TextStyle();

  @override
  Widget build(BuildContext context) {
    return Html(
      data: text.replaceAll('\n', '</br>'),
      onLinkTap: (String? url, __, ___, ____) {
        onLinkTap?.call(url);
      },
      style: <String, Style>{
        _body: Style.fromTextStyle(textStyle).merge(
          Style(
            margin: EdgeInsets.zero,
            padding: EdgeInsets.zero,
            textAlign: textAlign,
          ),
        ),
        _paragraph: Style.fromTextStyle(textStyle).merge(
          Style(
            margin: EdgeInsets.zero,
            padding: EdgeInsets.zero,
          ),
        ),
        _link: Style.fromTextStyle(
          textStyle,
        ),
        _highlight: Style.fromTextStyle(
          textStyle.copyWith(fontWeight: FontWeight.bold),
        ),
        _colored: Style.fromTextStyle(
          textStyle.copyWith(color: coloredTextColor),
        ),
        _highlightColored: Style.fromTextStyle(
          textStyle.copyWith(
            color: coloredTextColor,
            fontWeight: FontWeight.bold,
          ),
        ),
      },
      customRender: <String, CustomRender>{
        _highlight: (RenderContext context, _) {
          return TextSpan(
            text: context.tree.element!.text,
            style: context.style.generateTextStyle(),
          );
        },
        _colored: (RenderContext context, _) {
          return TextSpan(
            text: context.tree.element!.text,
            style: context.style.generateTextStyle(),
          );
        },
        _highlightColored: (RenderContext context, _) {
          return TextSpan(
            text: context.tree.element!.text,
            style: context.style.generateTextStyle(),
          );
        },
      },
      tagsList: Html.tags
        ..addAll(
          <String>[
            _highlight,
            _colored,
            _highlightColored,
          ],
        ),
    );
  }
}
