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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            height: 68,
            decoration: BoxDecoration(
              color: AppTheme.textFieldBackgroundColor,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Padding(
              padding: const EdgeInsets.only(left: 10, top: 20, bottom: 15),
              child: TextField(
                inputFormatters: widget.inputFormatters,
                keyboardType: widget.keyboardType,
                focusNode: focusNode,
                controller: _textEditingController,
                cursorColor: AppTheme.accentColor,
                obscureText: _obscureText,
                cursorHeight: 24,
                decoration: InputDecoration(
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
                  filled: true,
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
                  labelText: widget.hintText,
                  fillColor: AppTheme.textFieldBackgroundColor,
                  labelStyle: AppTextTheme.manrope24Regular.copyWith(
                    color: AppTheme.textHintColor,
                  ),
                  floatingLabelStyle: AppTextTheme.manrope19Medium.copyWith(
                    height: 0.4,
                    color: AppTheme.textHintColor,
                  ),
                  errorStyle: AppTextTheme.manrope14Medium.copyWith(
                    color: AppTheme.errorColor,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(16),
                    ),
                    borderSide: BorderSide(
                      color: AppTheme.textFieldBackgroundColor,
                    ),
                  ),
                ),
                style: AppTextTheme.manrope20Regular.copyWith(
                  color: AppTheme.accentColor,
                ),
                onChanged: widget.onChanged,
              ),
            ),
          ),
          if (widget.errorText != null) ...<Widget>{
            Padding(
              padding: const EdgeInsets.only(left: 10, top: 5),
              child: Text(
                widget.errorText!,
                style: AppTextTheme.manrope14Medium.copyWith(
                  color: AppTheme.errorColor,
                ),
              ),
            ),
          }
        ],
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
