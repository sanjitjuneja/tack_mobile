import 'dart:async';

import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:flutter/cupertino.dart';

import '../../bloc/tacks_bloc.dart';
import 'runner_tack/runner_task_widget.dart';

class RunnerTacksWidget extends StatelessWidget {
  const RunnerTacksWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text(
          FlutterI18n.translate(
            context,
            'tacksScreen.runner.subtitle',
          ),
          style: AppTextTheme.manrope13Medium
              .copyWith(color: AppTheme.textHeavyHintColor),
        ),
        const SizedBox(height: 10),
        Expanded(
          child: BlocBuilder<TacksBloc, TacksState>(
            builder: (_, TacksState state) {
              return AppListViewWithRefresh(
                enableRefresh: true,
                enableLoad: state.runnerTacksData.canLoadMore,
                isLoading: state.isLoading,
                hasData: state.runnerTacksData.hasData,
                emptyWidget: EmptyWidget(
                  svgIcon: AppIconsTheme.tacksList,
                  descriptionKey: 'tacksScreen.empty.runnerTacks.description',
                  buttonLabelKey: 'tacksScreen.empty.runnerTacks.buttonLabel',
                  onButtonTap: () => _onEmptyStateButtonTap(context),
                ),
                onRefresh: _onRefreshAction,
                onLoad: _onLoadMoreAction,
                itemCount: state.runnerTacksData.results.length,
                itemBuilder: (_, int index) {
                  return RunnerTackWidget(
                    runnerTack: state.runnerTacksData.results[index],
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }

  void _onEmptyStateButtonTap(BuildContext context) {
    BlocProvider.of<TacksBloc>(context).add(const MoveToHomeTab());
  }

  void _onRefreshAction(
    BuildContext context,
    Completer<RefreshingStatus> completer,
  ) {
    BlocProvider.of<TacksBloc>(context)
        .add(RefreshRunnerTacks(completer: completer));
  }

  void _onLoadMoreAction(
    BuildContext context,
    Completer<LoadingStatus> completer,
  ) {
    BlocProvider.of<TacksBloc>(context)
        .add(LoadRunnerTacks(completer: completer));
  }
}
