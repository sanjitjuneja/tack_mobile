import 'dart:async';

import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:flutter/cupertino.dart';

import '../../bloc/previous_tacks_bloc.dart';
import 'completed_tack_tile.dart';

class CompletedTacksWidget extends StatelessWidget {
  const CompletedTacksWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PreviousTacksBloc, PreviousTacksState>(
      builder: (_, PreviousTacksState state) {
        return AppListViewWithRefresh(
          enableRefresh: true,
          enableLoad: state.completedTacksData.canLoadMore,
          isLoading: state.isLoading,
          hasData: state.completedTacksData.hasData,
          emptyWidget: EmptyWidget(
            svgIcon: AppIconsTheme.tacksList,
            descriptionKey:
                'previousTacksScreen.empty.completedTacks.description',
            buttonLabelKey:
                'previousTacksScreen.empty.completedTacks.buttonLabel',
            onButtonTap: () => _onEmptyStateButtonTap(context),
          ),
          onRefresh: _onRefreshAction,
          onLoad: _onLoadMoreAction,
          itemCount: state.completedTacksData.results.length,
          itemBuilder: (_, int index) {
            return CompletedTackTile(
              tack: state.completedTacksData.results[index],
            );
          },
        );
      },
    );
  }

  void _onEmptyStateButtonTap(BuildContext context) {
    BlocProvider.of<PreviousTacksBloc>(context).add(
      const MoveToHomeTab(),
    );
  }

  void _onRefreshAction(
    BuildContext context,
    Completer<RefreshingStatus> completer,
  ) {
    BlocProvider.of<PreviousTacksBloc>(context).add(
      RefreshCompletedTacks(completer: completer),
    );
  }

  void _onLoadMoreAction(
    BuildContext context,
    Completer<LoadingStatus> completer,
  ) {
    BlocProvider.of<PreviousTacksBloc>(context).add(
      LoadCompletedTacks(completer: completer),
    );
  }
}
