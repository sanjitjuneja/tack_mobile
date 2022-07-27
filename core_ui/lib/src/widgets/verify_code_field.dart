import 'package:core_ui/core_ui.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class VerifyCodeField extends StatefulWidget {
  final TextEditingController controller;
  final Function(String) onChanged;

  const VerifyCodeField({
    Key? key,
    required this.onChanged,
    required this.controller,
  }) : super(key: key);

  @override
  State<VerifyCodeField> createState() => _VerifyCodeFieldState();
}

class _VerifyCodeFieldState extends State<VerifyCodeField> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: PinCodeTextField(
        length: 6,
        autoFocus: true,
        appContext: context,
        animationType: AnimationType.none,
        showCursor: false,
        enableActiveFill: true,
        cursorColor: Colors.black,
        autoDismissKeyboard: false,
        animationCurve: Curves.ease,
        controller: widget.controller,
        keyboardType: TextInputType.number,
        backgroundColor: AppTheme.positiveColor,
        textStyle: AppTextTheme.manrope32Medium,
        animationDuration: const Duration(seconds: 0),
        pinTheme: PinTheme(
          shape: PinCodeFieldShape.box,
          borderRadius: BorderRadius.circular(16),
          fieldHeight: 82.0,
          fieldWidth: 52.0,
          activeColor: AppTheme.textFieldBackgroundColor,
          selectedColor: widget.controller.text.length == 6
              ? AppTheme.textFieldBackgroundColor
              : AppTheme.textFieldBackgroundColor,
          inactiveColor: AppTheme.textFieldBackgroundColor,
          disabledColor: AppTheme.textFieldBackgroundColor,
          activeFillColor: AppTheme.textFieldBackgroundColor,
          selectedFillColor: AppTheme.textFieldBackgroundColor,
          inactiveFillColor: AppTheme.textFieldBackgroundColor,
          errorBorderColor: AppTheme.textFieldBackgroundColor,
        ),
        onChanged: (value) {
          widget.onChanged(value);
        },
      ),
    );
  }
}
