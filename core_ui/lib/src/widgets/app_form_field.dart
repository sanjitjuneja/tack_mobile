import 'package:core_ui/core_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppTextFormField extends StatefulWidget {
  final String hintText;
  final bool obscureText;
  final Widget? suffixIcon;
  final String? initText;
  final String? errorText;
  final TextInputType? keyboardType;
  final bool showObscureButton;
  final void Function(String newText) onChanged;
  final List<TextInputFormatter>? inputFormatters;

  const AppTextFormField({
    required this.hintText,
    required this.onChanged,
    this.initText,
    this.errorText,
    this.suffixIcon,
    this.keyboardType,
    this.inputFormatters,
    this.obscureText = false,
    this.showObscureButton = false,
    Key? key,
  }) : super(key: key);

  @override
  State<AppTextFormField> createState() => _AppTextFormFieldState();
}

class _AppTextFormFieldState extends State<AppTextFormField> {
  final FocusNode focusNode = FocusNode();
  late final TextEditingController _textEditingController;
  late bool _obscureText;

  @override
  void initState() {
    _textEditingController = TextEditingController(text: widget.initText);
    _obscureText = widget.obscureText;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppTheme.transparentColor,
      child: TextField(
        inputFormatters: widget.inputFormatters,
        obscureText: _obscureText,
        obscuringCharacter: '*',
        controller: _textEditingController,
        keyboardType: widget.keyboardType,
        decoration: InputDecoration(
          filled: true,
          fillColor: AppTheme.textFieldBackgroundColor,
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(16),
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: const BorderRadius.all(
              Radius.circular(16),
            ),
            borderSide: BorderSide(
              color: AppTheme.textFieldBackgroundColor,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: const BorderRadius.all(
              Radius.circular(16),
            ),
            borderSide: BorderSide(
              color: AppTheme.textFieldBackgroundColor,
            ),
          ),
          errorStyle: AppTextTheme.manrope14Medium.copyWith(
            color: AppTheme.errorColor,
          ),
          labelText: widget.hintText,
          labelStyle: AppTextTheme.manrope24Regular.copyWith(
            color: AppTheme.textHintColor,
          ),
          floatingLabelStyle: AppTextTheme.manrope14Regular.copyWith(
            height: 4,
            color: AppTheme.textHintColor,
          ),
          suffixIcon: widget.suffixIcon ??
              (widget.showObscureButton
                  ? Padding(
                      padding: const EdgeInsets.only(right: 24),
                      child: GestureDetector(
                        onTap: _changePasswordVisibility,
                        child: _obscureText
                            ? AppImagesTheme.visibilityOn
                            : AppImagesTheme.visibilityOff,
                      ),
                    )
                  : null),
          errorText: widget.errorText,
          errorMaxLines: 2,
          focusedBorder: OutlineInputBorder(
            borderRadius: const BorderRadius.all(
              Radius.circular(16),
            ),
            borderSide: BorderSide(
              color: AppTheme.textFieldBackgroundColor,
            ),
          ),
        ),
        cursorColor: AppTheme.accentColor,
        onChanged: widget.onChanged,
        style: AppTextTheme.manrope20Regular.copyWith(
          color: AppTheme.accentColor,
        ),
      ),
    );
  }

  void _changePasswordVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }
}
