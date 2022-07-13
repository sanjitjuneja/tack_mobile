import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:flutter/cupertino.dart';

class SectionHeaderWidget extends StatelessWidget {
  final String labelKey;
  final bool isRequired;

  const SectionHeaderWidget({
    super.key,
    required this.labelKey,
    this.isRequired = true,
  });

  @override
  Widget build(BuildContext context) {
    final TextStyle defaultStyle = AppTextTheme.manrope14Regular
        .copyWith(color: AppTheme.textPrimaryColor);

    return Align(
      alignment: Alignment.centerLeft,
      child: RichText(
        text: TextSpan(
          children: <TextSpan>[
            TextSpan(
              text: FlutterI18n.translate(context, labelKey),
              style: defaultStyle,
            ),
            if (isRequired)
              TextSpan(
                text: ' *',
                style: defaultStyle.copyWith(color: AppTheme.errorColor),
              ),
          ],
        ),
      ),
    );
  }
}
