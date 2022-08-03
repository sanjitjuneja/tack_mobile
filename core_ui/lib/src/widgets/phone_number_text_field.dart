import 'package:core/core.dart';
import 'package:core_ui/src/theme/app_theme.dart';
import 'package:flutter/material.dart';

class PhoneNumberTextField extends StatelessWidget {
  final Function(String value) onChanged;
  final TextEditingController controller;

  const PhoneNumberTextField({
    Key? key,
    required this.onChanged,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: TextField(
        autofocus: true,
        controller: controller,
        cursorColor: AppTheme.accentColor,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          filled: true,
          fillColor: AppTheme.textFieldBackgroundColor,
          border: InputBorder.none,
          contentPadding: EdgeInsets.zero,
        ),
        inputFormatters: PhoneNumberFormatter.phoneInputFormatters,
        style: AppTextTheme.manrope25Medium.copyWith(
          color: AppTheme.accentColor,
          letterSpacing: 3,
        ),
        onChanged: (String value) {
          onChanged(value);
        },
      ),
    );
  }
}
