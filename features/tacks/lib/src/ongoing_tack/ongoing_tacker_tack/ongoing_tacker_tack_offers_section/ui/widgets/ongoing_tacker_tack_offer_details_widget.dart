import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:domain/domain.dart';
import 'package:flutter/cupertino.dart';

import '../../bloc/offers_bloc.dart';

class OngoingTackerTackOfferDetailsWidget extends StatelessWidget {
  final Offer offer;

  const OngoingTackerTackOfferDetailsWidget({
    super.key,
    required this.offer,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        if (offer.type == OfferType.counterOffer) ...<Widget>[
          Text(
            CurrencyUtility.dollarFormat.format(offer.price),
            style: AppTextTheme.manrope18Bold
                .copyWith(color: AppTheme.textSecondaryColor),
          ),
          const SizedBox(height: 4),
        ],
        TimeLeftWidget(
          tillTime: offer.expiredAt,
          onExpire: _onOfferExpired,
          builder: (_, String content) {
            return AppButton(
              shouldDisableTap: true,
              labelWidget: SizedBox(
                width: 40,
                child: Text(
                  content,
                  textAlign: TextAlign.center,
                  style: AppTextTheme.manrope14Medium
                      .copyWith(color: AppTheme.warningColor),
                ),
              ),
              type: ButtonType.secondary,
              padding: const EdgeInsets.symmetric(
                vertical: 6.0,
                horizontal: 26.0,
              ),
              borderColor: AppTheme.warningColor,
              expanded: false,
            );
          },
        ),
      ],
    );
  }

  void _onOfferExpired(BuildContext context) {
    BlocProvider.of<OffersBloc>(context).add(
      OfferExpiredAction(
        offerId: offer.id,
      ),
    );
  }
}
