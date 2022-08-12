import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:flutter/cupertino.dart';

class NavigationBarActionButton extends StatelessWidget {
  final String labelKey;
  final void Function(BuildContext) onTap;
  final HapticFeedbackType feedbackType;
  final bool withFeedback;
  final ButtonType type;
  final bool isDisabled;
  final AppIcon? icon;
  final bool withBorder;
  final bool withShadow;
  final double? horizontalPadding;

  const NavigationBarActionButton({
    super.key,
    required this.labelKey,
    required this.onTap,
    this.feedbackType = HapticFeedbackType.heavy,
    this.withFeedback = false,
    this.type = ButtonType.secondary,
    this.isDisabled = false,
    this.icon,
    this.withBorder = false,
    this.withShadow = false,
    this.horizontalPadding,
  });

  @override
  Widget build(BuildContext context) {
    return AppButton(
      labelKey: labelKey,
      icon: icon,
      feedbackType: feedbackType,
      withFeedback: withFeedback,
      type: type,
      isDisabled: isDisabled,
      withShadow: withShadow,
      borderColor:
          type.isPrimary && !withBorder ? AppTheme.transparentColor : null,
      padding: const EdgeInsets.symmetric(
        vertical: 6.0,
        horizontal: 16.0,
      ).copyWith(
        left: horizontalPadding,
        right: horizontalPadding,
      ),
      expanded: false,
      onTap: () => onTap(context),
    );
  }
}
