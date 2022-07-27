import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:domain/domain.dart';
import 'package:flutter/cupertino.dart';

import 'package:tacks/src/ongoing_tack/ongoing_tacker_tack/bloc/ongoing_tacker_tack_bloc.dart';
import 'package:tacks/src/ongoing_tack/ongoing_tacker_tack/ui/widgets/ongoing_tacker_tack_offer/ongoing_tacker_tack_offer_details_widget.dart';
import 'package:tacks/src/ongoing_tack/ongoing_tacker_tack/ui/widgets/ongoing_tacker_tack_offer/ongoing_tacker_tack_offer_user_widget.dart';

class OngoingTackerTackOfferWidget extends StatelessWidget {
  final Offer offer;

  const OngoingTackerTackOfferWidget({
    super.key,
    required this.offer,
  });

  @override
  Widget build(BuildContext context) {
    return OpacityOnTapContainer(
      onTap: () => _onOfferPressed(context),
      pressedOpacity: 0.85,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 16.0,
          vertical: 8.0,
        ),
        decoration: BoxDecoration(
          color: AppTheme.primaryColor,
          borderRadius: BorderRadius.circular(16.0),
          boxShadow: WidgetShadowType.heavy.shadow,
        ),
        child: Row(
          children: <Widget>[
            Expanded(
              child: OngoingTackerTackOfferUserWidget(runner: offer.runner),
            ),
            const SizedBox(width: 8),
            OngoingTackerTackOfferDetailsWidget(offer: offer),
            const SizedBox(width: 8),
            AppIconsTheme.chevronRight(),
          ],
        ),
      ),
    );
  }

  void _onOfferPressed(BuildContext context) {
    BlocProvider.of<OngoingTackerTackBloc>(context)
        .add(SelectOffer(offer: offer));
  }
}
