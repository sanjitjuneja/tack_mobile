import 'package:core_ui/core_ui.dart';
import 'package:flutter/cupertino.dart';

class GroupButtonSectionButton extends StatelessWidget {
  final String labelKey;
  final AppIcon icon;
  final Color? interfaceColor;
  final VoidCallback onTap;

  const GroupButtonSectionButton({
    super.key,
    required this.labelKey,
    required this.icon,
    required this.onTap,
    this.interfaceColor,
  });

  @override
  Widget build(BuildContext context) {
    return AppButton(
      labelKey: labelKey,
      textStyle: AppTextTheme.manrope18Medium,
      interfaceColor: interfaceColor,
      padding: const EdgeInsets.symmetric(vertical: 14),
      icon: icon,
      type: ButtonType.secondary,
      onTap: onTap,
    );
  }
}
