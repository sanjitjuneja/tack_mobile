import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:domain/domain.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:tacks/src/ongoing_tack/ongoing_tacker_tack/bloc/ongoing_tacker_tack_bloc.dart';
import 'package:tacks/src/ongoing_tack/ongoing_tacker_tack/ui/widgets/ongoing_tacker_tack_offer/ongoing_tacker_tack_offer_widget.dart';
import 'package:tacks/src/ongoing_tack/view_extensions/ongoing_tack_to_view_extension.dart';

class OngoingTackerTackOffersSection extends StatelessWidget {
  final OngoingTackerTackState state;

  const OngoingTackerTackOffersSection({
    super.key,
    required this.state,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedSize(
      duration: state.isLoading
          ? const Duration(milliseconds: 1)
          : const Duration(milliseconds: 350),
      alignment: Alignment.topCenter,
      child: AnimatedSwitcher(
        duration: state.isLoading
            ? const Duration(milliseconds: 1)
            : const Duration(milliseconds: 500),
        child: state.isLoading
            ? Padding(
                padding: const EdgeInsets.only(top: 20, bottom: 4.0),
                child: AppProgressIndicator(
                  indicatorSize: ProgressIndicatorSize.medium,
                  backgroundColor: AppTheme.transparentColor,
                ),
              )
            : GroupedListView<Offer, OfferType>(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                elements: state.offers,
                groupBy: (Offer element) => element.type,
                groupSeparatorBuilder: (OfferType groupType) {
                  return Padding(
                    padding: EdgeInsets.only(
                      top: groupType == OfferType.counterOffer ? 30 : 0,
                      bottom: 8.0,
                    ),
                    child: Text(
                      FlutterI18n.translate(context, groupType.title),
                      style: AppTextTheme.manrope20Regular
                          .copyWith(color: AppTheme.textPrimaryColor),
                    ),
                  );
                },
                itemBuilder: (_, Offer item) => OngoingTackerTackOfferWidget(
                  offer: item,
                ),
                itemComparator: (Offer first, Offer second) {
                  return first.type.index.compareTo(second.type.index);
                },
                separator: const SizedBox(height: 14),
                floatingHeader: true,
                order: GroupedListOrder.ASC,
              ),
      ),
    );
  }
}
