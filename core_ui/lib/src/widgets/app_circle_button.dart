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
  final EdgeInsets? margin;
  final TextStyle? interfaceTextStyle;
  final Color? backgroundColor;
  final VoidCallback? onTap;

  const AppCircleButton({
    super.key,
    required this.labelKey,
    this.type = AppButtonType.primary,
    this.interfaceSize = AppInterfaceSize.medium,
    this.isDisabled = false,
    this.margin,
    this.interfaceTextStyle,
    this.backgroundColor,
    this.onTap,
  });

  Color get _backgroundColor {
    if (backgroundColor != null) return backgroundColor!;

    return type.isPrimary
        ? AppTheme.buttonPrimaryColor
        : AppTheme.buttonSecondaryColor;
  }

  Color get _interfaceColor => type.isPrimary
      ? AppTheme.buttonInterfacePrimaryColor
      : AppTheme.buttonInterfaceSecondaryColor;

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

  Color get _borderColor => type.isPrimary
      ? AppTheme.buttonPrimaryColor
      : AppTheme.buttonBorderSecondaryColor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: margin ?? EdgeInsets.zero,
      child: OpacityOnTapContainer(
        onTap: onTap,
        disable: isDisabled,
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(19.0),
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
