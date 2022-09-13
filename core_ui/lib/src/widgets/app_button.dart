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
  final String? labelKey;
  final Widget? labelWidget;
  final TextStyle? textStyle;
  final EdgeInsets? padding;
  final AppIcon? icon;
  final double? iconSize;
  final BoxConstraints? constraints;
  final ButtonType type;
  final BoxShape shape;
  final Color? interfaceColor;
  final Color? backgroundColor;
  final Color? borderColor;
  final HapticFeedbackType feedbackType;
  final bool withFeedback;
  final bool withShadow;
  final bool isDisabled;
  final bool shouldDisableTap;
  final bool expanded;
  final void Function()? onTap;

  const AppButton({
    super.key,
    this.labelKey,
    this.labelWidget,
    this.textStyle,
    this.padding,
    this.icon,
    this.iconSize,
    this.constraints,
    this.type = ButtonType.primary,
    this.shape = BoxShape.rectangle,
    this.interfaceColor,
    this.backgroundColor,
    this.borderColor,
    this.feedbackType = HapticFeedbackType.heavy,
    this.withFeedback = false,
    this.withShadow = true,
    this.isDisabled = false,
    this.shouldDisableTap = false,
    this.expanded = true,
    this.onTap,
  }) : assert(labelKey != null || labelWidget != null || icon != null);

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
    final bool needSeparator =
        icon != null && labelKey != null || icon != null && labelWidget != null;

    final Color? resultBorderColor = borderColor ?? interfaceColor;

    return OpacityOnTapContainer(
      onTap: onTap,
      feedbackType: feedbackType,
      withFeedback: withFeedback,
      disable: shouldDisableTap || isDisabled,
      child: Container(
        constraints: constraints,
        padding: shape == BoxShape.rectangle
            ? padding ??
                const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 10.0,
                )
            : const EdgeInsets.all(12.0),
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
          shape: shape,
          borderRadius:
              shape == BoxShape.rectangle ? BorderRadius.circular(12) : null,
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
          mainAxisSize: expanded ? MainAxisSize.max : MainAxisSize.min,
          children: <Widget>[
            if (icon != null) ...<Widget>[
              icon!.call(
                color: contentColor,
                size: iconSize ?? contentStyle.fontSize! * 1.3,
              ),
            ],
            if (needSeparator) const SizedBox(width: 10),
            if (labelKey != null || labelWidget != null) ...<Widget>[
              Flexible(
                child: labelWidget ??
                    Text(
                      FlutterI18n.translate(context, labelKey!),
                      textAlign: TextAlign.center,
                      style: contentStyle,
                    ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
