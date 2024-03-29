import 'package:core/core.dart';
import 'package:core_ui/src/theme/app_theme.dart';
import 'package:core_ui/src/widgets/app_button_type.dart';
import 'package:core_ui/src/widgets/app_interface_size.dart';
import 'package:core_ui/src/widgets/opacity_on_tap_container.dart';
import 'package:flutter/cupertino.dart';

class AppCircleButton extends StatelessWidget {
  final String labelKey;
  final AppButtonType type;
  final AppInterfaceSize interfaceSize;
  final bool isDisabled;
  final EdgeInsets? padding;
  final EdgeInsets? margin;
  final TextStyle? interfaceTextStyle;
  final Color? backgroundColor;
  final Color? borderColor;
  final Color? interfaceColor;
  final HapticFeedbackType feedbackType;
  final bool withFeedback;
  final bool expanded;
  final VoidCallback? onTap;

  const AppCircleButton({
    super.key,
    required this.labelKey,
    this.type = AppButtonType.primary,
    this.interfaceSize = AppInterfaceSize.medium,
    this.isDisabled = false,
    this.padding,
    this.margin,
    this.interfaceTextStyle,
    this.backgroundColor,
    this.borderColor,
    this.interfaceColor,
    this.feedbackType = HapticFeedbackType.heavy,
    this.withFeedback = false,
    this.expanded = true,
    this.onTap,
  });

  Color get _backgroundColor {
    if (backgroundColor != null) return backgroundColor!;

    return type.isPrimary
        ? AppTheme.buttonPrimaryColor
        : AppTheme.buttonSecondaryColor;
  }

  Color get _interfaceColor {
    if (interfaceColor != null) return interfaceColor!;

    return type.isPrimary
        ? AppTheme.buttonInterfacePrimaryColor
        : AppTheme.buttonInterfaceSecondaryColor;
  }

  TextStyle get _interfaceTextStyle {
    if (interfaceTextStyle != null) return interfaceTextStyle!;

    switch (interfaceSize) {
      case AppInterfaceSize.small:
        return AppTextTheme.manrope14Regular;
      case AppInterfaceSize.medium:
        return AppTextTheme.manrope16SemiBold;
      case AppInterfaceSize.big:
        return AppTextTheme.manrope20Medium;
    }
  }

  Color get _borderColor {
    if (borderColor != null) return borderColor!;

    return type.isPrimary
        ? AppTheme.buttonPrimaryColor
        : AppTheme.buttonBorderSecondaryColor;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: margin ?? EdgeInsets.zero,
      child: OpacityOnTapContainer(
        onTap: onTap,
        feedbackType: feedbackType,
        withFeedback: withFeedback,
        disable: isDisabled,
        child: Container(
          width: expanded ? double.infinity : null,
          padding: padding ??
              const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 16,
              ),
          decoration: BoxDecoration(
            color: _backgroundColor,
            border: Border.all(color: _borderColor),
            borderRadius: BorderRadius.circular(100),
            shape: BoxShape.rectangle,
          ),
          child: Text(
            FlutterI18n.translate(context, labelKey),
            textAlign: TextAlign.center,
            style: _interfaceTextStyle.copyWith(color: _interfaceColor),
          ),
        ),
      ),
    );
  }
}
