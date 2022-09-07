import 'package:core/core.dart';
import 'package:flutter/material.dart';

import '../../core_ui.dart';

class RoundedCustomButton extends StatelessWidget {
  final String text;
  final Color backgroundColor;

  final Image? image;
  final double? width;
  final double? height;
  final bool isEnabled;
  final TextStyle? textStyle;
  final String? disabledText;
  final BorderSide? borderSide;
  final List<BoxShadow>? shadows;
  final BorderRadius? borderRadius;
  final TextStyle? disabledTextStyle;
  final Color? disabledBackgroundColor;
  final Color? onPressedBackgroundColor;

  final void Function()? onPressed;

  const RoundedCustomButton({
    required this.text,
    required this.backgroundColor,
    this.image,
    this.width,
    this.height,
    this.shadows,
    this.onPressed,
    this.textStyle,
    this.borderSide,
    this.borderRadius,
    this.disabledText,
    this.isEnabled = true,
    this.disabledTextStyle,
    this.disabledBackgroundColor,
    this.onPressedBackgroundColor,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: borderRadius ?? BorderRadius.circular(12),
      child: Material(
        child: Container(
          decoration: BoxDecoration(
            boxShadow: shadows ?? [],
          ),
          width: width ?? double.infinity,
          height: height ?? 55,
          child: ElevatedButton(
            style: ButtonStyle(
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              shadowColor: MaterialStateProperty.all(Colors.transparent),
              overlayColor: MaterialStateProperty.all(Colors.transparent),
              shape: MaterialStateProperty.all(
                RoundedRectangleBorder(
                  side: borderSide ?? BorderSide.none,
                  borderRadius: borderRadius ?? BorderRadius.circular(12),
                ),
              ),
              backgroundColor: MaterialStateProperty.resolveWith(
                (Set<MaterialState> states) {
                  if (states.contains(MaterialState.pressed)) {
                    return isEnabled
                        ? onPressedBackgroundColor ?? backgroundColor
                        : disabledBackgroundColor ?? backgroundColor;
                  } else {
                    return isEnabled
                        ? backgroundColor
                        : disabledBackgroundColor ?? backgroundColor;
                  }
                },
              ),
            ),
            onPressed: isEnabled ? onPressed : () {},
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                if (image != null) ...<Widget>{
                  image!,
                  const SizedBox(width: 10),
                },
                isEnabled
                    ? Text(
                        FlutterI18n.translate(context, text),
                        style: textStyle ??
                            AppTextTheme.manrope14Medium.copyWith(
                              color: AppTheme.textBrightColor,
                            ),
                        overflow: TextOverflow.visible,
                        textAlign: TextAlign.center,
                      )
                    : Text(
                        disabledText != null
                            ? FlutterI18n.translate(context, disabledText!)
                            : FlutterI18n.translate(context, text),
                        style: disabledTextStyle ??
                            textStyle ??
                            AppTextTheme.manrope14Medium.copyWith(
                              color: AppTheme.accentColor,
                            ),
                        overflow: TextOverflow.visible,
                        textAlign: TextAlign.center,
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
