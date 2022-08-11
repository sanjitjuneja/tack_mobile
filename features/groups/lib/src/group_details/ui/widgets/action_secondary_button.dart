import 'package:core_ui/core_ui.dart';
import 'package:flutter/cupertino.dart';

class ActionSecondaryButton extends StatelessWidget {
  final String labelKey;
  final void Function(BuildContext context) onTap;

  const ActionSecondaryButton({
    super.key,
    required this.labelKey,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return AppCircleButton(
      labelKey: labelKey,
      type: AppButtonType.secondary,
      onTap: () => onTap(context),
    );
  }
}
