import 'package:core_ui/core_ui.dart';
import 'package:flutter/cupertino.dart';

enum ButtonType {
  primary,
  secondary;

  bool get isPrimary {
    return this == ButtonType.primary;
  }
}

class AppButton extends StatelessWidget {
  final String label;
  final AppIcon? icon;
  final ButtonType type;
  final Color? textColor;
  final Color? backgroundColor;
  final Color? borderColor;
  final bool withShadow;
  final bool isDisabled;
  final void Function()? onTap;

  const AppButton({
    super.key,
    required this.label,
    this.icon,
    this.type = ButtonType.primary,
    this.textColor,
    this.backgroundColor,
    this.borderColor,
    this.withShadow = true,
    this.isDisabled = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final Color contentColor = isDisabled
        ? AppTheme.buttonDisabledColor
        : textColor ??
            (type.isPrimary
                ? AppTheme.buttonInterfacePrimaryColor
                : AppTheme.buttonInterfaceSecondaryColor);

    return OpacityOnTapContainer(
      onTap: onTap,
      disable: isDisabled,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        decoration: BoxDecoration(
          color: isDisabled
              ? AppTheme.buttonSecondaryColor
              : backgroundColor ??
                  (type.isPrimary
                      ? AppTheme.buttonPrimaryColor
                      : AppTheme.buttonSecondaryColor),
          border: Border.all(
            color: isDisabled
                ? AppTheme.buttonDisabledColor
                : borderColor ??
                    (type.isPrimary
                        ? AppTheme.buttonBorderPrimaryColor
                        : AppTheme.buttonBorderSecondaryColor),
          ),
          borderRadius: BorderRadius.circular(12),
          boxShadow: withShadow
              ? const <BoxShadow>[
                  BoxShadow(
                    color: AppTheme.shadowColor,
                    offset: Offset(0, 4),
                    blurRadius: 4,
                  ),
                ]
              : null,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            if (icon != null) ...<Widget>[
              icon!.call(
                color: contentColor,
                size: 16,
              ),
              const SizedBox(width: 10),
            ],
            Flexible(
              child: Text(
                label,
                textAlign: TextAlign.center,
                style: AppTextTheme.manrope14Medium.copyWith(
                  color: contentColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
