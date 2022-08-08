import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:domain/domain.dart';
import 'package:flutter/cupertino.dart';

class TemplateTackHeader extends StatelessWidget {
  final TemplateTack tack;

  const TemplateTackHeader({
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
              CurrencyUtility.dollarFormat.format(tack.price),
              style: AppTextTheme.manrope24Bold
                  .copyWith(color: AppTheme.textSecondaryColor),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Row(
          children: <Widget>[
            Expanded(
              child: Text(
                DurationUtility.durationFormatString(
                    tack.estimatedTime, context),
                style: AppTextTheme.manrope16Bold
                    .copyWith(color: AppTheme.textHeavyHintColor),
              ),
            ),
            const SizedBox(width: 6),
            Text(
              tack.allowCounterOffers
                  ? FlutterI18n.translate(
                      context,
                      'createTackScreen.templateTack.counterOffer',
                    )
                  : '',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ],
    );
  }
}
