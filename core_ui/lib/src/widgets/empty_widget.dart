import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:flutter/cupertino.dart';

class EmptyWidget extends StatelessWidget {
  final AppIcon svgIcon;
  final String descriptionKey;
  final String buttonLabelKey;
  final VoidCallback onButtonTap;

  const EmptyWidget({
    super.key,
    required this.svgIcon,
    required this.descriptionKey,
    required this.buttonLabelKey,
    required this.onButtonTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40.0),
      child: Column(
        children: <Widget>[
          const Spacer(flex: 1),
          LayoutBuilder(
            builder: (_, BoxConstraints constraints) {
              return Container(
                width: constraints.maxWidth,
                padding: const EdgeInsets.symmetric(vertical: 30),
                decoration: BoxDecoration(
                  color: AppTheme.primaryColor,
                  borderRadius: BorderRadius.circular(18),
                ),
                child: svgIcon.svg(
                  fit: BoxFit.fitHeight,
                  size: constraints.maxWidth * 0.5,
                ),
              );
            },
          ),
          const SizedBox(height: 28),
          Text(
            FlutterI18n.translate(context, descriptionKey),
            textAlign: TextAlign.center,
            style: AppTextTheme.manrope14Medium
                .copyWith(color: AppTheme.textHintColor),
          ),
          const SizedBox(height: 48),
          AppCircleButton(
            labelKey: buttonLabelKey,
            onTap: onButtonTap,
          ),
          const Spacer(flex: 2),
        ],
      ),
    );
  }
}
