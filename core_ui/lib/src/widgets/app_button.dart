import 'package:core_ui/core_ui.dart';
import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
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
  final TextStyle? disabledTextStyle;
  final Color? disabledBackgroundColor;
  final Color? onPressedBackgroundColor;

  final void Function()? onPressed;

  const AppButton({
    required this.text,
    required this.backgroundColor,
    this.image,
    this.width,
    this.height,
    this.shadows,
    this.onPressed,
    this.textStyle,
    this.borderSide,
    this.disabledText,
    this.isEnabled = true,
    this.disabledTextStyle,
    this.disabledBackgroundColor,
    this.onPressedBackgroundColor,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
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
              borderRadius: BorderRadius.circular(12),
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
                    text,
                    style: textStyle ??
                        AppTextTheme.manrope14Medium.copyWith(
                          color: AppTheme.positiveColor,
                        ),
                    overflow: TextOverflow.visible,
                    textAlign: TextAlign.center,
                  )
                : Text(
                    disabledText ?? text,
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
    );
  }
}
