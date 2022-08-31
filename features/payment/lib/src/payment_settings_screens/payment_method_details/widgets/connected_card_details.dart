import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:domain/domain.dart';
import 'package:flutter/cupertino.dart';

class ConnectedCardDetails extends StatelessWidget {
  final ConnectedCard card;

  const ConnectedCardDetails({
    Key? key,
    required this.card,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 22,
        vertical: 16,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: AppTheme.textFieldSecondaryBackgroundColor,
        boxShadow: const <BoxShadow>[
          BoxShadow(
            color: AppColors.black25,
            offset: Offset(0.0, 4.0),
            spreadRadius: 0.0,
            blurRadius: 4.0,
          ),
        ],
      ),
      child: AspectRatio(
        aspectRatio: Constants.paymentMethodCardRatio,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  card.cardData.brand,
                  style: AppTextTheme.manrope20Regular,
                ),
                AppNetworkImageWidget(
                  card.cardData.imageUrl,
                  placeholderIcon: AppIconsTheme.bank,
                  boxShape: BoxShape.rectangle,
                  boxFit: BoxFit.fitWidth,
                  isShadowBorder: false,
                  diameter: 35,
                ),
              ],
            ),
            const SizedBox(height: 14),
            Text(
              '****${card.cardData.last4}',
              style: AppTextTheme.manrope18Regular.copyWith(
                color: AppTheme.textHeavyHintColor,
              ),
            ),
            const SizedBox(height: 32),
            Text(
              FlutterI18n.translate(
                context,
                'paymentMethodDetailsScreen.expiryDate',
              ),
              style: AppTextTheme.manrope16Regular.copyWith(
                color: AppTheme.textHeavyHintColor,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              '${card.cardData.expMonth}/${card.cardData.expYear}',
              style: AppTextTheme.manrope18Medium,
            ),
          ],
        ),
      ),
    );
  }
}
