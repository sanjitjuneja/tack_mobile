import 'dart:async';

import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:flutter/cupertino.dart';

import 'package:tacks/src/tacks_screen/bloc/tacks_bloc.dart';
import 'package:tacks/src/tacks_screen/ui/widgets/tacker_tack/tacker_tack_widget.dart';

class TackerTacksWidget extends StatelessWidget {
  const TackerTacksWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TacksBloc, TacksState>(
      builder: (_, TacksState state) {
        return AppListViewWithRefresh(
          enableRefresh: true,
          enableLoad: state.tackerTacksState.canLoadMore,
          isLoading: state.tackerTacksState.isLoading,
          hasData: state.tackerTacksState.hasData,
          emptyWidget: EmptyWidget(
            svgIcon: AppIconsTheme.tacksList,
            descriptionKey: 'tacksScreen.empty.tackerTacks.description',
            buttonLabelKey: 'tacksScreen.empty.tackerTacks.buttonLabel',
            onButtonTap: () => _onEmptyStateButtonTap(context),
          ),
          onRefresh: _onRefreshAction,
          onLoad: _onLoadMoreAction,
          itemCount: state.tackerTacksState.tacks.length,
          itemBuilder: (_, int index) {
            return TackerTackWidget(
              tack: state.tackerTacksState.tacks[index],
            );
          },
        );
      },
    );
  }

  void _onEmptyStateButtonTap(BuildContext context) {
    BlocProvider.of<TacksBloc>(context).add(const MoveToAddTab());
  }

  void _onRefreshAction(
    BuildContext context,
    Completer<RefreshingStatus> completer,
  ) {
    BlocProvider.of<TacksBloc>(context)
        .add(RefreshTackerTacks(completer: completer));
  }

  void _onLoadMoreAction(
    BuildContext context,
    Completer<LoadingStatus> completer,
  ) {
    BlocProvider.of<TacksBloc>(context)
        .add(LoadTackerTacks(completer: completer));
  }
}
