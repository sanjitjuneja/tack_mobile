import 'package:core_ui/core_ui.dart';
import 'package:domain/domain.dart';
import 'package:flutter/cupertino.dart';

class TemplateTackFooter extends StatelessWidget {
  final TemplateTack tack;
  final void Function(BuildContext) onActionPressed;

  const TemplateTackFooter({
    super.key,
    required this.tack,
    required this.onActionPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          tack.description,
          style: AppTextTheme.manrope14Regular.copyWith(
            color: AppTheme.textHintColor,
            height: 1.5,
          ),
        ),
        const SizedBox(height: 12),
        AppButton(
          labelKey: 'createTackScreen.templateTack.editAndPublishButton',
          icon: AppIconsTheme.edit,
          withFeedback: true,
          onTap: () => onActionPressed(context),
        )
      ],
    );
  }
}
