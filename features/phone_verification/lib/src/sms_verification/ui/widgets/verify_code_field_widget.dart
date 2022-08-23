import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:flutter/material.dart';

import '../../bloc/sms_verification_bloc.dart';

class VerifyCodeFieldWidget extends StatelessWidget {
  const VerifyCodeFieldWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: PinCodeTextField(
        length: 6,
        autoFocus: true,
        appContext: context,
        animationType: AnimationType.none,
        showCursor: true,
        enableActiveFill: true,
        cursorColor: AppTheme.textPrimaryColor,
        autoDismissKeyboard: false,
        animationCurve: Curves.ease,
        keyboardType: TextInputType.number,
        backgroundColor: AppTheme.transparentColor,
        textStyle: AppTextTheme.manrope32Medium,
        animationDuration: const Duration(seconds: 0),
        pinTheme: PinTheme(
          shape: PinCodeFieldShape.box,
          borderRadius: BorderRadius.circular(16),
          fieldHeight: 76.0,
          fieldWidth: 50.0,
          activeColor: AppTheme.textFieldBackgroundColor,
          selectedColor: AppTheme.textFieldBackgroundColor,
          inactiveColor: AppTheme.textFieldBackgroundColor,
          disabledColor: AppTheme.textFieldBackgroundColor,
          activeFillColor: AppTheme.textFieldBackgroundColor,
          selectedFillColor: AppTheme.textFieldBackgroundColor,
          inactiveFillColor: AppTheme.textFieldBackgroundColor,
          errorBorderColor: AppTheme.textFieldBackgroundColor,
        ),
        onChanged: (String value) => _onCodeChanged(context, value),
      ),
    );
  }

  void _onCodeChanged(BuildContext context, String code) {
    BlocProvider.of<SmsVerificationBloc>(context).add(
      CodeChanged(verificationCode: code),
    );
  }
}
