import 'dart:async';

import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:flutter/cupertino.dart';

import '../../bloc/groups_bloc.dart';
import '../bloc/my_groups_bloc.dart';
import 'widgets/group_tile/group_tile.dart';

class MyGroupsForm extends StatelessWidget {
  const MyGroupsForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GroupsBloc, GroupsState>(
      builder: (_, GroupsState state) {
        return PageContainerWithAddButton(
          onAddButtonPressed: _onCreateGroupButtonPressed,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const PageHeaderWidget(
                titleKey: 'groupsScreen.title',
                descriptionKey: 'groupsScreen.description',
              ),
              const SizedBox(height: 4),
              Expanded(
                child: AppListViewWithRefresh(
                  enableRefresh: true,
                  enableLoad: state.groupsData.canLoadMore,
                  isLoading: state.isLoading,
                  hasData: state.groupsData.hasData,
                  emptyWidget: const EmptyWidget(
                    svgIcon: AppIconsTheme.people,
                    descriptionKey: 'groupsScreen.empty.description',
                  ),
                  onRefresh: _onRefreshAction,
                  onLoad: _onLoadMoreAction,
                  itemCount: state.groupsData.results.length,
                  itemBuilder: (_, int index) {
                    return GroupTile(
                      groupDetails: state.groupsData.results[index],
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _onCreateGroupButtonPressed(BuildContext context) {
    BlocProvider.of<MyGroupsBloc>(context).add(CreateGroup());
  }

  void _onRefreshAction(
    BuildContext context,
    Completer<RefreshingStatus> completer,
  ) {
    BlocProvider.of<GroupsBloc>(context).add(
      RefreshAction(completer: completer),
    );
  }

  void _onLoadMoreAction(
    BuildContext context,
    Completer<LoadingStatus> completer,
  ) {
    BlocProvider.of<GroupsBloc>(context).add(
      LoadMoreAction(completer: completer),
    );
  }
}
