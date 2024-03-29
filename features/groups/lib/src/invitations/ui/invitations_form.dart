import 'dart:async';

import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:flutter/cupertino.dart';

import '../bloc/invitations_bloc.dart';
import 'widgets/invitation_tile.dart';

class InvitationsForm extends StatelessWidget {
  const InvitationsForm({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<InvitationsBloc, InvitationsState>(
      builder: (_, InvitationsState state) {
        return Column(
          children: <Widget>[
            const PageHeaderWidget(
              titleKey: 'invitationsScreen.title',
              descriptionKey: 'invitationsScreen.description',
            ),
            const SizedBox(height: 4),
            Expanded(
              child: AppListViewWithRefresh(
                enableRefresh: true,
                enableLoad: state.invitationsData.canLoadMore,
                isLoading: state.isLoading,
                hasData: state.invitationsData.hasData,
                emptyWidget: const EmptyWidget(
                  svgIcon: AppIconsTheme.people,
                  descriptionKey: 'invitationsScreen.empty.description',
                ),
                onRefresh: _onRefreshAction,
                onLoad: _onLoadMoreAction,
                itemCount: state.invitationsData.results.length,
                itemBuilder: (_, int index) {
                  return InvitationTile(
                    invitation: state.invitationsData.results[index],
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
    BlocProvider.of<InvitationsBloc>(context)
        .add(RefreshAction(completer: completer));
  }

  void _onLoadMoreAction(
    BuildContext context,
    Completer<LoadingStatus> completer,
  ) {
    BlocProvider.of<InvitationsBloc>(context)
        .add(LoadMoreAction(completer: completer));
  }
}
