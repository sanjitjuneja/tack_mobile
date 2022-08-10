import 'package:core_ui/core_ui.dart';
import 'package:flutter/cupertino.dart';

class ActionPrimaryButton extends StatelessWidget {
  final String labelKey;
  final void Function(BuildContext context) onTap;

  const ActionPrimaryButton({
    super.key,
    required this.labelKey,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return AppCircleButton(
      labelKey: labelKey,
      onTap: () => onTap(context),
    );
  }
}
