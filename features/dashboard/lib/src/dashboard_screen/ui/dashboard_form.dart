import 'dart:async';

import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:dashboard/src/bloc/dashboard_bloc.dart';
import 'package:dashboard/src/widgets/tack_tile.dart';
import 'package:domain/domain.dart';
import 'package:flutter/cupertino.dart';
import 'package:home/home.dart';
import 'package:navigation/navigation.dart';

class DashboardForm extends StatelessWidget {
  const DashboardForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GlobalBloc, GlobalState>(
      builder: (_, GlobalState state) {
        if (state.isGroupSelected) {
          return BlocProvider<DashboardBloc>(
            key: ValueKey<Group>(state.currentGroup!),
            create: (_) => DashboardBloc(
              appRouter: appLocator.get<AppRouterDelegate>(),
              fetchGroupTacksUseCase: appLocator.get<FetchGroupTacksUseCase>(),
              makeOfferUseCase: appLocator.get<MakeOfferUseCase>(),
              selectedGroup: state.currentGroup!,
            ),
            child: BlocBuilder<DashboardBloc, DashboardState>(
              builder: (BuildContext blocContext, DashboardState state) {
                return AppListViewWithRefresh(
                  enableRefresh: true,
                  enableLoad: state.tacksData.canLoadMore,
                  isLoading: state.isLoading,
                  hasData: state.tacksData.hasData,
                  emptyWidget: EmptyWidget(
                    svgIcon: AppIconsTheme.people,
                    descriptionKey: 'dashboardScreen.noTacks.description',
                    buttonLabelKey: 'dashboardScreen.noTacks.labelButton',
                    onButtonTap: () =>
                        _onNoTacksButtonPressed(blocContext),
                  ),
                  onRefresh: _onRefreshAction,
                  onLoad: _onLoadMoreAction,
                  itemCount: state.tacksData.results.length,
                  itemBuilder: (_, int index) {
                    return TackTile(
                      tack: state.tacksData.results[index],
                    );
                  },
                );
              },
            ),
          );
        } else {
          return Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: EmptyWidget(
              svgIcon: AppIconsTheme.people,
              titleKey: 'dashboardScreen.emptyNoGroupSelected.title',
              descriptionKey:
                  'dashboardScreen.emptyNoGroupSelected.description',
              buttonLabelKey:
                  'dashboardScreen.emptyNoGroupSelected.labelButton',
              onButtonTap: () => _onNoGroupButtonPressed(context),
            ),
          );
        }
      },
    );
  }

  void _onRefreshAction(
    BuildContext context,
    Completer<RefreshingStatus> completer,
  ) {
    BlocProvider.of<DashboardBloc>(context)
        .add(RefreshAction(completer: completer));
  }

  void _onLoadMoreAction(
    BuildContext context,
    Completer<LoadingStatus> completer,
  ) {
    BlocProvider.of<DashboardBloc>(context)
        .add(LoadMoreAction(completer: completer));
  }

  void _onNoGroupButtonPressed(BuildContext context) {
    BlocProvider.of<GlobalBloc>(context).add(const GoToMyInvitations());
  }

  void _onNoTacksButtonPressed(BuildContext context) {
    BlocProvider.of<DashboardBloc>(context).add(const GoToCreateTack());
  }
}
