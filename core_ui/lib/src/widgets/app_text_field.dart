import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:core_ui/src/theme/app_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

// TODO: refactor.
class AppTextField extends StatefulWidget {
  final TextEditingController? controller;
  final String? initialText;
  final String placeholder;
  final EdgeInsets? padding;
  final Color? backgroundColor;
  final bool shouldShowCursor;
  final bool isDisabled;
  final Function()? onTap;
  final bool? forceFocus;
  final bool isInvalid;
  final bool shouldObscure;
  final bool hasDecoration;
  final bool hasShadow;
  final bool isRequired;
  final double? height;
  final int? minLines;
  final int? maxLines;
  final Widget? suffix;
  final TextAlign textAlign;
  final Iterable<String>? autofillHints;
  final void Function(String)? onTextChange;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;

  const AppTextField({
    super.key,
    required this.placeholder,
    this.initialText,
    this.padding,
    this.controller,
    this.backgroundColor,
    this.isDisabled = false,
    this.onTap,
    this.forceFocus,
    this.isInvalid = false,
    this.shouldObscure = false,
    this.hasDecoration = true,
    this.hasShadow = true,
    bool? isRequired,
    this.height,
    this.textAlign = TextAlign.left,
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
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  late TextEditingController _controller;

  bool get _isReadOnly => widget.onTap != null;

  @override
  void initState() {
    if (widget.initialText != null) {
      _controller = TextEditingController()..value = _initialFormattedText;
    } else {
      _controller = widget.controller ?? TextEditingController();
    }

    super.initState();
  }

  TextEditingValue get _initialFormattedText {
    final List<TextInputFormatter>? inputFormatters = widget.inputFormatters;
    TextEditingValue editingValue = TextEditingValue(text: widget.initialText!);

    if (inputFormatters != null) {
      for (final TextInputFormatter formatter in inputFormatters) {
        editingValue =
            formatter.formatEditUpdate(TextEditingValue.empty, editingValue);
      }
    }

    return editingValue;
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoTextField(
      suffix: widget.suffix,
      textAlignVertical: TextAlignVertical.center,
      decoration: widget.hasDecoration
          ? BoxDecoration(
              color: widget.backgroundColor ??
                  AppTheme.textFieldPrimaryBackgroundColor,
              borderRadius: BorderRadius.circular(16),
              boxShadow: widget.hasShadow
                  ? <BoxShadow>[
                      BoxShadow(
                        color: AppTheme.shadowColor,
                        offset: const Offset(0, 4),
                        blurRadius: 4,
                      ),
                    ]
                  : null,
            )
          : null,
      obscureText: widget.shouldObscure,
      readOnly: _isReadOnly,
      controller: _controller,
      cursorColor: AppTheme.textPrimaryColor,
      padding: widget.padding ??
          const EdgeInsets.only(
            left: 20,
            right: 10,
            top: 23,
            bottom: 23,
          ),
      placeholder: <String>[
        FlutterI18n.translate(context, widget.placeholder),
        (widget.isRequired ? '*' : '')
      ].join(''),
      scrollPadding: const EdgeInsets.all(30),
      minLines: widget.minLines,
      maxLines: widget.maxLines,
      style: widget.isDisabled
          ? AppTextTheme.manrope16Regular.copyWith(
              color: AppTheme.textPrimaryColor,
            )
          : AppTextTheme.manrope16Regular.copyWith(
              color: AppTheme.textPrimaryColor,
            ),
      textAlign: widget.textAlign,
      autofillHints: widget.autofillHints,
      onChanged: (String text) => widget.onTextChange?.call(text),
      keyboardType: widget.keyboardType,
      inputFormatters: widget.inputFormatters,
      placeholderStyle: AppTextTheme.manrope16Regular.copyWith(
        color: AppTheme.textHintColor,
      ),
    );
  }
}
