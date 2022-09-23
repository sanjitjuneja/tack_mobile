import 'package:core/core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

import '../theme/app_theme.dart';
import 'keyboard_overlay/keyboard_overlay.dart';
import 'opacity_on_tap_container.dart';

// TODO: refactor.
class AppTextField extends StatefulWidget {
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final String? initialText;
  final bool shouldUpdateInitialText;
  final String? placeholder;
  final EdgeInsets? padding;
  final TextStyle? textStyle;
  final Color? backgroundColor;
  final bool shouldShowCursor;
  final bool isDisabled;
  final bool isReadOnly;
  final Function()? onTap;
  final bool autoFocus;
  final bool shouldShowOverlayIfNeeded;
  final bool isInvalid;
  final String? errorTextKey;
  final bool shouldObscure;
  final bool hasDecoration;
  final bool hasShadow;
  final bool isRequired;
  final double? height;
  final int? minLines;
  final int? maxLines;
  final Widget? prefix;
  final Widget? suffix;
  final TextAlign textAlign;
  final Iterable<String>? autofillHints;
  final void Function(String)? onTextChange;
  final void Function(TextEditingController)? onFocusLost;
  final TextInputAction? textInputAction;
  final TextInputType? keyboardType;
  final TextCapitalization textCapitalization;
  final List<TextInputFormatter>? inputFormatters;
  final double? scrollPadding;

  const AppTextField({
    super.key,
    this.placeholder,
    this.initialText,
    this.shouldUpdateInitialText = false,
    this.padding,
    this.textStyle,
    this.controller,
    this.focusNode,
    this.backgroundColor,
    this.isDisabled = false,
    this.isReadOnly = false,
    this.onTap,
    this.autoFocus = false,
    this.shouldShowOverlayIfNeeded = true,
    this.isInvalid = false,
    this.errorTextKey,
    this.shouldObscure = false,
    this.hasDecoration = true,
    this.hasShadow = true,
    bool? isRequired,
    this.height,
    this.textAlign = TextAlign.left,
    this.minLines,
    this.maxLines,
    this.prefix,
    this.suffix,
    bool shouldShowCursor = true,
    this.autofillHints,
    this.onTextChange,
    this.onFocusLost,
    this.textInputAction,
    this.keyboardType,
    this.textCapitalization = TextCapitalization.none,
    this.inputFormatters,
    this.scrollPadding,
  })  : shouldShowCursor = !isDisabled && (shouldShowCursor || onTap != null),
        isRequired = isRequired ?? false;

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  static const List<TextInputType> _typesForOverlay = <TextInputType>[
    TextInputType.numberWithOptions(decimal: true),
    TextInputType.numberWithOptions(),
  ];

  late TextEditingController _controller;
  late FocusNode focusNode;
  late bool shouldUseOverlay;
  late bool isObscureVisible;

  bool get _isReadOnly => widget.isReadOnly || widget.onTap != null;

  @override
  void initState() {
    super.initState();
    focusNode = widget.focusNode ?? FocusNode();
    shouldUseOverlay = widget.shouldShowOverlayIfNeeded &&
        _typesForOverlay.contains(widget.keyboardType);
    isObscureVisible = !widget.shouldObscure;

    if (widget.initialText != null) {
      _controller = TextEditingController()..value = _initialFormattedText;
    } else {
      _controller = widget.controller ?? TextEditingController();
    }

    focusNode.addListener(() {
      if (focusNode.hasFocus) return;

      widget.onFocusLost?.call(_controller);
    });
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
  void didUpdateWidget(AppTextField oldWidget) {
    final bool didUpdateInitialText =
        oldWidget.initialText != widget.initialText;

    final bool shouldUpdateInitialText =
        didUpdateInitialText && widget.shouldUpdateInitialText;

    if (shouldUpdateInitialText) {
      _controller.text = widget.initialText ?? '';
    }

    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        KeyboardOverlayWidget(
          isEnabled: shouldUseOverlay,
          focusNode: focusNode,
          child: CupertinoTextField(
            textCapitalization: widget.textCapitalization,
            prefix: widget.prefix,
            suffix: widget.suffix != null
                ? Padding(
                    padding: const EdgeInsets.only(right: 20),
                    child: widget.suffix,
                  )
                : (widget.shouldObscure
                    ? Padding(
                        padding: const EdgeInsets.only(right: 20),
                        child: OpacityOnTapContainer(
                          onTap: _changeObscureVisibility,
                          child: isObscureVisible
                              ? AppImagesTheme.visibilityOn
                              : AppImagesTheme.visibilityOff,
                        ),
                      )
                    : null),
            focusNode: focusNode,
            autofocus: widget.autoFocus,
            textAlignVertical: TextAlignVertical.center,
            decoration: widget.hasDecoration
                ? BoxDecoration(
                    color: widget.backgroundColor ??
                        AppTheme.textFieldPrimaryBackgroundColor,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: widget.isInvalid
                          ? AppTheme.errorColor
                          : AppTheme.transparentColor,
                    ),
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
            obscureText: !isObscureVisible,
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
              if (widget.placeholder != null) ...<String>[
                FlutterI18n.translate(context, widget.placeholder!),
                if (widget.isRequired) '*',
              ],
            ].join(' '),
            scrollPadding: EdgeInsets.all(widget.scrollPadding ?? 30),
            minLines: widget.shouldObscure ? 1 : widget.minLines,
            maxLines: widget.shouldObscure ? 1 : widget.maxLines,
            style: widget.isDisabled
                ? (widget.textStyle ?? AppTextTheme.manrope16Regular).copyWith(
                    color: AppTheme.textHeavyHintColor,
                  )
                : (widget.textStyle ?? AppTextTheme.manrope16Regular).copyWith(
                    color: AppTheme.textPrimaryColor,
                  ),
            textAlign: widget.textAlign,
            autofillHints: widget.autofillHints,
            textInputAction: widget.textInputAction,
            keyboardType: widget.keyboardType,
            inputFormatters: widget.inputFormatters,
            placeholderStyle: AppTextTheme.manrope16Regular.copyWith(
              color: AppTheme.textHintColor,
            ),
            onChanged: (String text) => widget.onTextChange?.call(text),
          ),
        ),
        if (widget.errorTextKey != null && widget.isInvalid) ...<Widget>[
          const SizedBox(height: 4),
          Text(
            FlutterI18n.translate(context, widget.errorTextKey!),
            style: AppTextTheme.manrope14Medium
                .copyWith(color: AppTheme.errorColor),
          ),
        ],
      ],
    );
  }

  void _changeObscureVisibility() {
    setState(() => isObscureVisible = !isObscureVisible);
  }

  @override
  void dispose() {
    super.dispose();
  }
}
