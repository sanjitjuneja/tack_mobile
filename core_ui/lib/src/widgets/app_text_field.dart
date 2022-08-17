import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:core_ui/src/theme/app_theme.dart';
import 'package:core_ui/src/widgets/keyboard_overlay/keyboard_overlay.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

// TODO: refactor.
class AppTextField extends StatefulWidget {
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final String? initialText;
  final String placeholder;
  final EdgeInsets? padding;
  final Color? backgroundColor;
  final bool shouldShowCursor;
  final bool isDisabled;
  final Function()? onTap;
  final bool? forceFocus;
  final bool isInvalid;
  final String? errorTextKey;
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
  final void Function(TextEditingController)? onFocusLost;
  final TextInputAction? textInputAction;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;

  const AppTextField({
    super.key,
    required this.placeholder,
    this.initialText,
    this.padding,
    this.controller,
    this.focusNode,
    this.backgroundColor,
    this.isDisabled = false,
    this.onTap,
    this.forceFocus,
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
    this.suffix,
    bool shouldShowCursor = true,
    this.autofillHints,
    this.onTextChange,
    this.onFocusLost,
    this.textInputAction,
    this.keyboardType,
    this.inputFormatters,
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

  bool get _isReadOnly => widget.onTap != null;

  @override
  void initState() {
    super.initState();
    focusNode = widget.focusNode ?? FocusNode();
    shouldUseOverlay = _typesForOverlay.contains(widget.keyboardType);

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

    if (didUpdateInitialText &&
        (widget.initialText == null || widget.initialText!.isEmpty)) {
      _controller.text = '';
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
            suffix: widget.suffix,
            focusNode: focusNode,
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
              if (widget.isRequired) '*',
            ].join(' '),
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

  @override
  void dispose() {
    super.dispose();
  }
}
