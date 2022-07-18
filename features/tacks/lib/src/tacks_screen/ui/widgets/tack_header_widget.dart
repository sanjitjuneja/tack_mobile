import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:flutter/cupertino.dart';

class TackHeaderWidget extends StatelessWidget {
  final String name;
  final double fee;
  final Duration estimatedTime;
  final String description;
  final TextStyle? descriptionStyle;

  const TackHeaderWidget({
    super.key,
    required this.name,
    required this.fee,
    required this.estimatedTime,
    required this.description,
    this.descriptionStyle,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: Text(
                name,
                style: AppTextTheme.manrope16SemiBold
                    .copyWith(color: AppTheme.textPrimaryColor),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(width: 6),
            Text(
              CurrencyUtility.dollarFormat.format(fee),
              style: AppTextTheme.manrope24Bold
                  .copyWith(color: AppTheme.textSecondaryColor),
            ),
          ],
        ),
        const SizedBox(height: 18),
        Row(
          children: <Widget>[
            Expanded(
              child: Text(
                FlutterI18n.translate(context, description),
                style: descriptionStyle ??
                    AppTextTheme.manrope16Bold
                        .copyWith(color: AppTheme.textHeavyHintColor),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(width: 6),
            Text(
              DurationUtility.durationFormatString(estimatedTime, context),
              style: AppTextTheme.manrope16Bold
                  .copyWith(color: AppTheme.textHeavyHintColor),
            ),
          ],
        ),
      ],
    );
  }
}
