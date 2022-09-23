import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:domain/domain.dart';
import 'package:flutter/cupertino.dart';

import '../../view_extensions/runner_task_to_view_extension.dart';
import '../../view_extensions/tacker_task_to_view_extensions.dart';

class TackHeaderWidget extends StatelessWidget {
  final Tack tack;
  final bool isRunner;
  final double? counterOfferPrice;

  const TackHeaderWidget({
    super.key,
    required this.tack,
    required this.isRunner,
    this.counterOfferPrice,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 6.0),
                child: Text(
                  tack.title,
                  style: AppTextTheme.manrope16SemiBold
                      .copyWith(color: AppTheme.textPrimaryColor),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
            const SizedBox(width: 6),
            Text(
              CurrencyUtility.dollarFormat
                  .format(counterOfferPrice ?? tack.price),
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
                FlutterI18n.translate(
                  context,
                  isRunner
                      ? RunnerTackStatusToDescriptionExtension.finalDescription(
                          tack,
                        )
                      : TackerTackStatusToDescriptionExtension.finalDescription(
                          tack,
                        ),
                ),
                style: isRunner
                    ? RunnerTackStatusToTextStyleExtension.descriptionTextStyle(
                        tack,
                      )
                    : TackerTackStatusToTextStyleExtension.descriptionTextStyle(
                        tack,
                      ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            if (tack.estimatedTime != null) ...<Widget>[
              const SizedBox(width: 6),
              Text(
                DurationUtility.durationFormatString(
                  tack.estimatedTime!,
                  context,
                ),
                style: AppTextTheme.manrope16Bold
                    .copyWith(color: AppTheme.textHeavyHintColor),
              ),
            ],
          ],
        ),
      ],
    );
  }
}
