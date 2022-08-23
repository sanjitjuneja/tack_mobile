import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:flutter/cupertino.dart';

class ValidationPointWidget extends StatelessWidget {
  final bool isValidationStarted;
  final bool isValidationPassed;
  final String descriptionKey;
  final String? exampleKey;

  const ValidationPointWidget({
    super.key,
    required this.isValidationStarted,
    required this.isValidationPassed,
    required this.descriptionKey,
    this.exampleKey,
  });

  @override
  Widget build(BuildContext context) {
    final Widget leadingIcon;

    if (!isValidationStarted) {
      leadingIcon = AppIconsTheme.point(
        size: 12,
      );
    } else if (isValidationPassed) {
      leadingIcon = AppIconsTheme.checkMark(
        color: AppTheme.successColor,
        size: 12,
      );
    } else {
      leadingIcon = AppIconsTheme.cross(
        color: AppTheme.errorColor,
        size: 12,
      );
    }

    return Row(
      children: <Widget>[
        leadingIcon,
        const SizedBox(width: 10),
        RichText(
          text: TextSpan(
            style: AppTextTheme.manrope14Medium
                .copyWith(color: AppTheme.textPrimaryColor),
            children: <InlineSpan>[
              TextSpan(
                text: FlutterI18n.translate(context, descriptionKey),
              ),
              const WidgetSpan(
                child: SizedBox(width: 4),
              ),
              if (exampleKey != null) ...<InlineSpan>[
                TextSpan(
                  text: FlutterI18n.translate(context, exampleKey!),
                  style: AppTextTheme.manrope14Medium
                      .copyWith(color: AppTheme.textHeavyHintColor),
                ),
              ]
            ],
          ),
        ),
      ],
    );
  }
}
