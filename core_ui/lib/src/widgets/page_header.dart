import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:flutter/cupertino.dart';

class PageHeaderWidget extends StatelessWidget {
  final String? titleKey;
  final String descriptionKey;

  const PageHeaderWidget({
    super.key,
    required this.descriptionKey,
    this.titleKey,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 42),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          if (titleKey != null) ...<Widget>[
            Text(
              FlutterI18n.translate(
                context,
                titleKey!,
              ),
              style: AppTextTheme.manrope24SemiBold.copyWith(
                color: AppTheme.textPrimaryColor,
              ),
            ),
            const SizedBox(height: 4),
          ],
          SizedBox(
            width: double.infinity,
            child: Text(
              FlutterI18n.translate(
                context,
                descriptionKey,
              ),
              style: AppTextTheme.manrope13Medium.copyWith(
                color: AppTheme.textHeavyHintColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
