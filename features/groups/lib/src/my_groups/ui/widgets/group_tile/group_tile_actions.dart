import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:domain/domain.dart';
import 'package:flutter/cupertino.dart';

import 'package:groups/src/my_groups/bloc/my_groups_bloc.dart';

class GroupTileActions extends StatelessWidget {
  final Group group;

  const GroupTileActions({
    super.key,
    required this.group,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: AppButton(
            labelKey: 'groupsScreen.groupInfoButton',
            padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 6.0),
            type: ButtonType.secondary,
            borderColor: AppTheme.buttonLightBorderColor,
            onTap: () => _onInfoButtonPressed(context),
          ),
        ),
        const SizedBox(width: 6),
        Expanded(
          child: AppButton(
            labelKey: 'groupsScreen.inviteMembersButton',
            padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 6.0),
            type: ButtonType.secondary,
            borderColor: AppTheme.buttonLightBorderColor,
            onTap: () => _onInviteMembersButtonPressed(context),
          ),
        ),
      ],
    );
  }

  void _onInfoButtonPressed(BuildContext context) {
    BlocProvider.of<MyGroupsBloc>(context).add(OpenGroupDetails(group: group));
  }

  void _onInviteMembersButtonPressed(BuildContext context) {
    BlocProvider.of<MyGroupsBloc>(context).add(InviteMembers(group: group));
  }
}
