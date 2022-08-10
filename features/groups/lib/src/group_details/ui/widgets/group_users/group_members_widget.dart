import 'dart:async';

import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:flutter/cupertino.dart';

import 'package:groups/src/group_details/bloc/group_details_bloc.dart';
import 'package:groups/src/group_details/ui/widgets/group_users/group_member_tile.dart';

class GroupMembersWidget extends StatelessWidget {
  const GroupMembersWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            FlutterI18n.translate(
              context,
              'groupDetailsScreen.members',
            ),
            style: AppTextTheme.manrope20Regular
                .copyWith(color: AppTheme.textPrimaryColor),
          ),
        ),
        const SizedBox(height: 10),
        Expanded(
          child: BlocBuilder<GroupDetailsBloc, GroupDetailsState>(
            builder: (BuildContext blocContext, GroupDetailsState state) {
              return AppListViewWithRefresh(
                enableRefresh: true,
                enableLoad: state.usersState.canLoadMore,
                isLoading: state.usersState.isLoading,
                hasData: state.usersState.hasData,
                emptyWidget: EmptyWidget(svgIcon: AppIconsTheme.people),
                onRefresh: _onRefreshAction,
                onLoad: _onLoadMoreAction,
                itemCount: state.usersState.members.length,
                itemBuilder: (_, int index) {
                  return GroupMemberTile(
                    member: state.usersState.members[index],
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
    BlocProvider.of<GroupDetailsBloc>(context)
        .add(RefreshAction(completer: completer));
  }

  void _onLoadMoreAction(
    BuildContext context,
    Completer<LoadingStatus> completer,
  ) {
    BlocProvider.of<GroupDetailsBloc>(context)
        .add(LoadMoreAction(completer: completer));
  }
}
