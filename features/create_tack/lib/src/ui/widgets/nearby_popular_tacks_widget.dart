import 'dart:async';

import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:create_tack/src/bloc/create_tack_bloc.dart';
import 'package:create_tack/src/ui/widgets/template_tack/template_tack_tile.dart';
import 'package:flutter/cupertino.dart';

class NearbyPopularTacksWidget extends StatelessWidget {
  const NearbyPopularTacksWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text(
          FlutterI18n.translate(
            context,
            'createTackScreen.nearbyPopular.subtitle',
          ),
          style: AppTextTheme.manrope13Medium
              .copyWith(color: AppTheme.textHeavyHintColor),
        ),
        const SizedBox(height: 10),
        Expanded(
          child: BlocBuilder<CreateTackBloc, CreateTackState>(
            builder: (_, CreateTackState state) {
              return AppListViewWithRefresh(
                enableRefresh: true,
                enableLoad: state.nearbyTacksState.canLoadMore,
                isLoading: state.nearbyTacksState.isLoading,
                hasData: state.nearbyTacksState.hasData,
                emptyWidget: EmptyWidget(
                  svgIcon: AppIconsTheme.tacksList,
                ),
                onRefresh: _onRefreshAction,
                itemCount: state.nearbyTacksState.tacks.length,
                itemBuilder: (_, int index) {
                  return TemplateTackTile(
                    tack: state.nearbyTacksState.tacks[index],
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }

  void _onRefreshAction(
    BuildContext context,
    Completer<RefreshingStatus> completer,
  ) {
    BlocProvider.of<CreateTackBloc>(context)
        .add(RefreshNearbyTacks(completer: completer));
  }
}
