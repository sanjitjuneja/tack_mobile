import 'dart:async';

import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:domain/domain.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../bloc/offers_bloc.dart';
import '../../../widgets/tack_details_section.dart';
import 'widgets/ongoing_tacker_tack_offer_tile.dart';

class OngoingTackerTackOffersSection extends StatelessWidget {
  final Tack tack;
  final EdgeInsets padding;

  const OngoingTackerTackOffersSection({
    super.key,
    required this.tack,
    required this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider<OffersBloc>(
      create: (_) {
        return OffersBloc(
          tack: tack,
          fetchTacksOffersUseCase: appLocator.get<FetchTackOffersUseCase>(),
          observeOfferIntentUseCase:
              appLocator.get<ObserveOfferIntentUseCase>(),
        );
      },
      child: BlocBuilder<OffersBloc, OffersState>(
        builder: (_, OffersState blocState) {
          return SafeArea(
            child: AppListViewWithRefresh(
              padding: padding,
              enableRefresh: true,
              enableLoad: blocState.offersData.canLoadMore,
              isLoading: blocState.isLoading,
              hasData: blocState.offersData.hasData,
              emptyWidget: EmptyWidget(
                svgIcon: AppIconsTheme.tacksList,
                footerPadding: EdgeInsets.only(
                  left: padding.left,
                  right: padding.right,
                ),
              ),
              headerWidget: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  TackDetailSection(
                    tack: tack,
                    hasDeleteAction: false,
                  ),
                  if (!blocState.isLoading) ...<Widget>[
                    const SizedBox(height: 20),
                    Text(
                      FlutterI18n.translate(
                        context,
                        'ongoingTackScreen.tacker.offers',
                        translationParams: <String, String>{
                          'count': blocState.offersData.count.toString()
                        },
                      ),
                      style: AppTextTheme.manrope20Regular
                          .copyWith(color: AppTheme.textPrimaryColor),
                    ),
                    const SizedBox(height: 10),
                  ],
                ],
              ),
              onRefresh: _onRefreshAction,
              onLoad: _onLoadMoreAction,
              itemCount: blocState.offersData.results.length,
              itemBuilder: (_, int index) {
                return OngoingTackerTackOfferTile(
                  offer: blocState.offersData.results[index],
                );
              },
            ),
          );
        },
      ),
    );
  }

  void _onRefreshAction(
    BuildContext context,
    Completer<RefreshingStatus> completer,
  ) {
    BlocProvider.of<OffersBloc>(context)
        .add(RefreshAction(completer: completer));
  }

  void _onLoadMoreAction(
    BuildContext context,
    Completer<LoadingStatus> completer,
  ) {
    BlocProvider.of<OffersBloc>(context)
        .add(LoadMoreAction(completer: completer));
  }
}
