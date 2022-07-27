import 'package:core/text_input_formatters/phone_number_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../core_ui.dart';

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
        inputFormatters: [
          PhoneNumberFormatter.phoneInputFormatter,
        ],
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
