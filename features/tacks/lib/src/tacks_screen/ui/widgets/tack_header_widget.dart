import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:domain/domain.dart';
import 'package:flutter/cupertino.dart';
import 'package:tacks/src/tacks_screen/view_extensions/tacker_task_to_view_extensions.dart';

class TackHeaderWidget extends StatelessWidget {
  final Tack tack;

  const TackHeaderWidget({
    super.key,
    required this.tack,
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
                tack.title,
                style: AppTextTheme.manrope16SemiBold
                    .copyWith(color: AppTheme.textPrimaryColor),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(width: 6),
            Text(
              CurrencyUtility.dollarFormat.format(tack.price),
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
                FlutterI18n.translate(context, tack.finalDescription),
                style: tack.descriptionTextStyle,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(width: 6),
            Text(
              DurationUtility.durationFormatString(tack.estimatedTime, context),
              style: AppTextTheme.manrope16Bold
                  .copyWith(color: AppTheme.textHeavyHintColor),
            ),
          ],
        ),
      ],
    );
  }
}
