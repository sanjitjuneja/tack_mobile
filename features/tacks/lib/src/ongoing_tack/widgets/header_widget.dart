import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:domain/domain.dart';
import 'package:flutter/cupertino.dart';

import 'package:tacks/src/ongoing_tack/view_extensions/ongoing_tack_to_view_extension.dart';

class HeaderWidget extends StatelessWidget {
  final Tack tack;
  final int stepsCount;
  final int currentStep;
  final bool isTacker;

  const HeaderWidget({
    super.key,
    required this.tack,
    required this.stepsCount,
    required this.currentStep,
    required this.isTacker,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: Text(
                DurationUtility.durationFormatString(
                  tack.estimatedTime,
                  context,
                ),
                maxLines: 1,
                style: AppTextTheme.manrope28Bold
                    .copyWith(color: AppTheme.textSecondaryColor),
              ),
            ),
            Text(
              FlutterI18n.translate(
                context,
                'ongoingTackScreen.estimatedTackTime',
              ),
              textAlign: TextAlign.end,
              style: AppTextTheme.manrope14SemiBold.copyWith(
                color: AppTheme.textSecondaryColor.withOpacity(0.67),
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        StepsWithProgressWidget(
          stepsCount: stepsCount,
          currentStep: currentStep,
        ),
        const SizedBox(height: 20),
        Text(
          FlutterI18n.translate(
            context,
            tack.status.getTitle(isTacker: isTacker),
          ),
          style: AppTextTheme.manrope20Bold
              .copyWith(color: AppTheme.textSecondaryColor),
        ),
        const SizedBox(height: 6),
        Text(
          FlutterI18n.translate(
            context,
            tack.status.getSubTitle(isTacker: isTacker),
          ),
          style: AppTextTheme.manrope14Medium.copyWith(
            color: AppTheme.textSecondaryColor.withOpacity(0.67),
          ),
        ),
      ],
    );
  }
}
