import 'dart:async';

import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:flutter/cupertino.dart';

import 'package:groups/src/my_groups/ui/widgets/group_tile/group_tile.dart';
import 'package:groups/src/my_groups/ui/widgets/my_groups_list_footer_widget.dart';

import '../bloc/groups_bloc.dart';

class MyGroupsForm extends StatelessWidget {
  const MyGroupsForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GroupsBloc, GroupsState>(
      builder: (_, GroupsState state) {
        return Column(
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
                enableLoad: state.canLoadMore,
                isLoading: state.isLoading,
                hasData: state.hasData,
                emptyWidget: EmptyWidget(
                  svgIcon: AppIconsTheme.people,
                  descriptionKey: 'groupsScreen.empty.description',
                  footer: const GroupsListFooterWidget(),
                ),
                onRefresh: _onRefreshAction,
                onLoad: _onLoadMoreAction,
                footerWidget: const GroupsListFooterWidget(),
                itemCount: state.groups.length,
                itemBuilder: (_, int index) {
                  return GroupTile(
                    group: state.groups[index],
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }

  void _onRefreshAction(
    BuildContext context,
    Completer<RefreshingStatus> completer,
  ) {
    BlocProvider.of<GroupsBloc>(context)
        .add(RefreshAction(completer: completer));
  }

  void _onLoadMoreAction(
    BuildContext context,
    Completer<LoadingStatus> completer,
  ) {
    BlocProvider.of<GroupsBloc>(context)
        .add(LoadMoreAction(completer: completer));
  }
}
