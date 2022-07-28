import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:flutter/cupertino.dart';

enum HeaderWeight {
  light,
  heavy;

  TextStyle get style {
    switch (this) {
      case HeaderWeight.light:
        return AppTextTheme.manrope14Regular;
      case HeaderWeight.heavy:
        return AppTextTheme.manrope14Bold;
    }
  }
}

class SectionHeaderWidget extends StatelessWidget {
  final String labelKey;
  final HeaderWeight headerWeight;
  final TextStyle textStyle;
  final bool isRequired;

  SectionHeaderWidget({
    super.key,
    required this.labelKey,
    this.headerWeight = HeaderWeight.light,
    TextStyle? textStyle,
    this.isRequired = true,
  }) : textStyle = (textStyle ?? headerWeight.style)
            .copyWith(color: AppTheme.textPrimaryColor);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: RichText(
        text: TextSpan(
          children: <TextSpan>[
            TextSpan(
              text: FlutterI18n.translate(context, labelKey),
              style: textStyle,
            ),
            if (isRequired) ...<TextSpan>[
              const TextSpan(text: '\t'),
              TextSpan(
                text: '*',
                style: textStyle.copyWith(color: AppTheme.errorColor),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
