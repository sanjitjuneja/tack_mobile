import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:flutter/cupertino.dart';

import 'package:groups/src/my_groups/bloc/groups_bloc.dart';

class GroupsListFooterWidget extends StatelessWidget {
  const GroupsListFooterWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 6.0),
      child: Row(
        children: <Widget>[
          Expanded(
            child: AppButton(
              labelKey: 'groupsScreen.myInvitationsButton',
              type: ButtonType.primary,
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              onTap: () => _onInvitationsButtonPressed(context),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: AppButton(
              labelKey: 'groupsScreen.createGroupButton',
              type: ButtonType.secondary,
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              onTap: () => _onCreateGroupButtonPressed(context),
            ),
          ),
        ],
      ),
    );
  }

  void _onInvitationsButtonPressed(BuildContext context) {
    BlocProvider.of<GroupsBloc>(context).add(OpenMyInvitations());
  }

  void _onCreateGroupButtonPressed(BuildContext context) {
    BlocProvider.of<GroupsBloc>(context).add(CreateGroup());
  }
}
