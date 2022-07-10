import 'package:core_ui/src/theme/app_theme.dart';
import 'package:core_ui/src/widgets/app_button_type.dart';
import 'package:core_ui/src/widgets/opacity_on_tap_container.dart';
import 'package:flutter/cupertino.dart';

class AppCircleButton extends StatelessWidget {
  final String label;
  final AppButtonType type;
  final bool isDisabled;
  final VoidCallback? onTap;

  const AppCircleButton({
    super.key,
    required this.label,
    this.type = AppButtonType.primary,
    this.isDisabled = false,
    this.onTap,
  });

  Color get _backgroundColor => type.isPrimary
      ? AppTheme.buttonPrimaryColor
      : AppTheme.buttonSecondaryColor;

  Color get _interfaceColor => type.isPrimary
      ? AppTheme.buttonInterfacePrimaryColor
      : AppTheme.buttonInterfaceSecondaryColor;

  Color get _borderColor => type.isPrimary
      ? AppTheme.buttonPrimaryColor
      : AppTheme.buttonBorderSecondaryColor;

  @override
  Widget build(BuildContext context) {
    return OpacityOnTapContainer(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(19.0),
        decoration: BoxDecoration(
          color: _backgroundColor,
          border: Border.all(color: _borderColor),
          borderRadius: BorderRadius.circular(100),
          shape: BoxShape.rectangle,
        ),
        // alignment: Alignment.center,
        child: Text(
          label,
          textAlign: TextAlign.center,
          style:
              AppTextTheme.manrope16SemiBold.copyWith(color: _interfaceColor),
        ),
      ),
    );
  }
}
