import 'package:core_ui/core_ui.dart';
import 'package:flutter/cupertino.dart';

class NavigationBarActionButton extends StatelessWidget {
  final String labelKey;
  final void Function(BuildContext) onTap;
  final ButtonType type;
  final bool isDisabled;
  final AppIcon? icon;
  final double? horizontalPadding;

  const NavigationBarActionButton({
    super.key,
    required this.labelKey,
    required this.onTap,
    this.type = ButtonType.secondary,
    this.isDisabled = false,
    this.icon,
    this.horizontalPadding,
  });

  @override
  Widget build(BuildContext context) {
    return AppButton(
      labelKey: labelKey,
      icon: icon,
      type: type,
      isDisabled: isDisabled,
      withShadow: false,
      borderColor: type.isPrimary ? AppTheme.transparentColor : null,
      padding: const EdgeInsets.symmetric(
        vertical: 6.0,
        horizontal: 16.0,
      ).copyWith(left: horizontalPadding, right: horizontalPadding),
      expanded: false,
      onTap: () => onTap(context),
    );
  }
}
