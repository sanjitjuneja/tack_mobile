import 'dart:async';

import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:flutter/cupertino.dart';

import '../../bloc/previous_tacks_bloc.dart';
import 'created_tack_tile.dart';

class CreatedTacksWidget extends StatelessWidget {
  const CreatedTacksWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PreviousTacksBloc, PreviousTacksState>(
      builder: (_, PreviousTacksState state) {
        return AppListViewWithRefresh(
          enableRefresh: true,
          enableLoad: state.createdTacksData.canLoadMore,
          isLoading: state.isLoading,
          hasData: state.createdTacksData.hasData,
          emptyWidget: EmptyWidget(
            svgIcon: AppIconsTheme.tacksList,
            descriptionKey:
                'previousTacksScreen.empty.createdTacks.description',
            buttonLabelKey:
                'previousTacksScreen.empty.createdTacks.buttonLabel',
            onButtonTap: () => _onEmptyStateButtonTap(context),
          ),
          onRefresh: _onRefreshAction,
          onLoad: _onLoadMoreAction,
          itemCount: state.createdTacksData.results.length,
          itemBuilder: (_, int index) {
            return CreatedTackTile(
              tack: state.createdTacksData.results[index],
            );
          },
        );
      },
    );
  }

  void _onEmptyStateButtonTap(BuildContext context) {
    BlocProvider.of<PreviousTacksBloc>(context).add(
      const MoveToCreateTackTab(),
    );
  }

  void _onRefreshAction(
    BuildContext context,
    Completer<RefreshingStatus> completer,
  ) {
    BlocProvider.of<PreviousTacksBloc>(context).add(
      RefreshCreatedTacks(completer: completer),
    );
  }

  void _onLoadMoreAction(
    BuildContext context,
    Completer<LoadingStatus> completer,
  ) {
    BlocProvider.of<PreviousTacksBloc>(context).add(
      LoadCreatedTacks(completer: completer),
    );
  }
}
