import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:flutter/cupertino.dart';

class OnboardingPage extends StatelessWidget {
  final String titleKey;
  final String descriptionKey;
  final AppIcon image;

  const OnboardingPage({
    super.key,
    required this.titleKey,
    required this.descriptionKey,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 48.0),
      child: Column(
        children: <Widget>[
          const SizedBox(height: 12),
          Expanded(
            child: image.svg(
              fit: BoxFit.fitWidth,
            ),
          ),
          const SizedBox(height: 20),
          Text(
            FlutterI18n.translate(context, titleKey),
            textAlign: TextAlign.center,
            style: AppTextTheme.manrope25Bold
                .copyWith(color: AppTheme.textPrimaryColor),
          ),
          const SizedBox(height: 4),
          ConstrainedBox(
            constraints: const BoxConstraints(minHeight: 80),
            child: Text(
              FlutterI18n.translate(context, descriptionKey),
              textAlign: TextAlign.center,
              style: AppTextTheme.manrope14Medium
                  .copyWith(color: AppTheme.textHintColor),
            ),
          ),
        ],
      ),
    );
  }
}
