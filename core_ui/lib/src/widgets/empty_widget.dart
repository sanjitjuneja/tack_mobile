import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:flutter/cupertino.dart';

class EmptyWidget extends StatelessWidget {
  final AppIcon svgIcon;
  final Color? iconColor;
  final String? titleKey;
  final String? descriptionKey;
  final Widget? footer;
  final EdgeInsets? footerPadding;
  final String? buttonLabelKey;
  final String? secondButtonLabelKey;
  final VoidCallback? onButtonTap;
  final VoidCallback? onSecondButtonTap;

  const EmptyWidget({
    super.key,
    required this.svgIcon,
    this.iconColor,
    this.titleKey,
    this.descriptionKey,
    this.footer,
    this.footerPadding,
    this.buttonLabelKey,
    this.secondButtonLabelKey,
    this.onButtonTap,
    this.onSecondButtonTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        const Spacer(flex: 1),
        Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            if (titleKey != null) ...<Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40.0),
                child: Text(
                  FlutterI18n.translate(context, titleKey!),
                  style: AppTextTheme.manrope24SemiBold,
                ),
              ),
              const SizedBox(height: 20),
            ],
          ],
        ),
        LayoutBuilder(
          builder: (_, BoxConstraints constraints) {
            return Container(
              width: constraints.maxWidth,
              margin: const EdgeInsets.symmetric(horizontal: 48.0),
              padding: const EdgeInsets.symmetric(vertical: 30.0),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: AppTheme.primaryColor,
                borderRadius: BorderRadius.circular(18),
              ),
              child: svgIcon.svg(
                color: iconColor ?? AppTheme.iconSecondaryColor,
                fit: BoxFit.fitHeight,
                size: constraints.maxWidth * 0.37,
              ),
            );
          },
        ),
        if (descriptionKey != null) ...<Widget>[
          const SizedBox(height: 28),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 44.0),
            child: Text(
              FlutterI18n.translate(context, descriptionKey!),
              textAlign: TextAlign.center,
              style: AppTextTheme.manrope14Medium
                  .copyWith(color: AppTheme.textHintColor),
            ),
          ),
        ],
        if (footer != null) ...<Widget>[
          const SizedBox(height: 48),
          Padding(
            padding:
                footerPadding ?? const EdgeInsets.symmetric(horizontal: 28.0),
            child: footer!,
          ),
        ],
        if (buttonLabelKey != null) ...<Widget>[
          const SizedBox(height: 28),
          AppCircleButton(
            margin: const EdgeInsets.symmetric(horizontal: 48.0),
            labelKey: buttonLabelKey!,
            onTap: onButtonTap,
          ),
          if (secondButtonLabelKey != null) ...<Widget>[
            const SizedBox(height: 10),
            AppCircleButton(
              margin: const EdgeInsets.symmetric(horizontal: 48.0),
              labelKey: secondButtonLabelKey!,
              onTap: onSecondButtonTap,
            ),
          ],
        ],
        const Spacer(flex: 5),
      ],
    );
  }
}
