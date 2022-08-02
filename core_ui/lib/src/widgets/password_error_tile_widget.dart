import 'package:core/core.dart';
import 'package:flutter/material.dart';

import '../../core_ui.dart';

class PasswordErrorTileWidget extends StatelessWidget {
  final bool isPassed;
  final String errorTextKey;
  final String descriptionKey;
  final bool isValidationStarted;

  const PasswordErrorTileWidget({
    required this.errorTextKey,
    required this.isPassed,
    required this.isValidationStarted,
    this.descriptionKey = '',
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        if (isValidationStarted) ...<Widget>{
          isPassed
              ? AppIconsTheme.success(
                  color: AppTheme.grassColor,
                )
              : AppIconsTheme.crossError(
                  color: AppTheme.errorColor,
                ),
        } else ...<Widget>{
          const RoundedListMarker(radius: 5),
        },
        const SizedBox(width: 11),
        Text(
          FlutterI18n.translate(context, errorTextKey),
          style: AppTextTheme.manrope14Medium.copyWith(
            color: AppTheme.accentColor,
          ),
        ),
        const SizedBox(width: 4),
        Text(
          FlutterI18n.translate(context, descriptionKey),
          style: AppTextTheme.manrope14Medium.copyWith(
            color: AppTheme.textDisabledColor,
          ),
        ),
      ],
    );
  }
}
