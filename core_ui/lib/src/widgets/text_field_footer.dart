import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:flutter/cupertino.dart';

class TextFieldFooter extends StatelessWidget {
  final String labelKey;
  final String content;
  final Size contentMaxSize;

  static TextStyle get textStyle => AppTextTheme.manrope12Medium.copyWith(
    color: AppTheme.textHintColor,
  );

  TextFieldFooter({
    super.key,
    required this.labelKey,
    required this.content,
    required String maxContent,
  }) : contentMaxSize = TextUtility.getTextSize(
    maxContent,
    textStyle: textStyle,
  );

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: RichText(
        text: TextSpan(
          style: textStyle,
          children: <InlineSpan>[
            TextSpan(
              text: FlutterI18n.translate(context, labelKey),
            ),
            const TextSpan(text: ': '),
            WidgetSpan(
              child: SizedBox(
                width: contentMaxSize.width,
                child: Text(
                  content,
                  style: textStyle,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
