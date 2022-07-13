import 'package:core/core.dart';
import 'package:core_ui/src/theme/app_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

class AppTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String placeholder;
  final Color? backgroundColor;
  final bool shouldShowCursor;
  final bool isDisabled;
  final Function()? onTap;
  final bool? forceFocus;
  final bool isInvalid;
  final bool shouldObscure;
  final bool hasShadow;
  final bool isRequired;
  final double? height;
  final int? minLines;
  final int? maxLines;
  final Widget? suffix;
  final Iterable<String>? autofillHints;
  final void Function(String)? onTextChange;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;

  bool get _isReadOnly => onTap != null;

  const AppTextField({
    super.key,
    required this.placeholder,
    this.controller,
    this.backgroundColor,
    this.isDisabled = false,
    this.onTap,
    this.forceFocus,
    this.isInvalid = false,
    this.shouldObscure = false,
    this.hasShadow = true,
    bool? isRequired,
    this.height,
    this.minLines,
    this.maxLines,
    this.suffix,
    bool shouldShowCursor = true,
    this.autofillHints,
    this.onTextChange,
    this.keyboardType,
    this.inputFormatters,
  })  : shouldShowCursor = !isDisabled && (shouldShowCursor || onTap != null),
        isRequired = isRequired ?? false;

  @override
  Widget build(BuildContext context) {
    return CupertinoTextField(
      suffix: suffix,
      textAlignVertical: TextAlignVertical.center,
      decoration: BoxDecoration(
        color: backgroundColor ?? AppTheme.textFieldPrimaryBackgroundColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: hasShadow
            ? const <BoxShadow>[
                BoxShadow(
                  color: AppTheme.shadowColor,
                  offset: Offset(0, 4),
                  blurRadius: 4,
                ),
              ]
            : null,
      ),
      obscureText: shouldObscure,
      readOnly: _isReadOnly,
      controller: controller,
      cursorColor: AppTheme.textPrimaryColor,
      padding: const EdgeInsets.only(
        left: 20,
        right: 10,
        top: 23,
        bottom: 23,
      ),
      placeholder:
          FlutterI18n.translate(context, placeholder) + (isRequired ? '*' : ''),
      scrollPadding: const EdgeInsets.all(30),
      minLines: minLines,
      maxLines: maxLines,
      style: isDisabled
          ? AppTextTheme.manrope16Regular
              .copyWith(color: AppTheme.textPrimaryColor)
          : AppTextTheme.manrope16Regular
              .copyWith(color: AppTheme.textPrimaryColor),
      placeholderStyle:
          AppTextTheme.manrope16Regular.copyWith(color: AppTheme.textHintColor),
      autofillHints: autofillHints,
      onChanged: (String text) => onTextChange?.call(text),
      keyboardType: keyboardType,
      inputFormatters: inputFormatters,
    );
  }
}
