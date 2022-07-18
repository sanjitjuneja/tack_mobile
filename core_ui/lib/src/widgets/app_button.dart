import 'package:core/core.dart';
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
  final String labelKey;
  final TextStyle? textStyle;
  final EdgeInsets? padding;
  final AppIcon? icon;
  final ButtonType type;
  final Color? interfaceColor;
  final Color? backgroundColor;
  final Color? borderColor;
  final bool withShadow;
  final bool isDisabled;
  final void Function()? onTap;

  const AppButton({
    super.key,
    required this.labelKey,
    this.textStyle,
    this.padding,
    this.icon,
    this.type = ButtonType.primary,
    this.interfaceColor,
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
        : interfaceColor ??
            (type.isPrimary
                ? AppTheme.buttonInterfacePrimaryColor
                : AppTheme.buttonInterfaceSecondaryColor);
    final TextStyle contentStyle = textStyle?.copyWith(color: contentColor) ??
        AppTextTheme.manrope14Medium.copyWith(
          color: contentColor,
        );

    final Color? resultBorderColor = borderColor ?? interfaceColor;

    return OpacityOnTapContainer(
      onTap: onTap,
      disable: isDisabled,
      child: Container(
        padding: padding ??
            const EdgeInsets.symmetric(
              vertical: 8.0,
              horizontal: 16.0,
            ),
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
                : resultBorderColor ??
                    (type.isPrimary
                        ? AppTheme.buttonBorderPrimaryColor
                        : AppTheme.buttonBorderSecondaryColor),
          ),
          borderRadius: BorderRadius.circular(12),
          boxShadow: withShadow && type.isPrimary
              ? <BoxShadow>[
                  BoxShadow(
                    color: AppTheme.shadowColor,
                    offset: const Offset(0, 4),
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
                size: contentStyle.fontSize! * 1.3,
              ),
              const SizedBox(width: 10),
            ],
            Flexible(
              child: Text(
                FlutterI18n.translate(context, labelKey),
                textAlign: TextAlign.center,
                style: contentStyle,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
