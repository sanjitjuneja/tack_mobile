import 'package:core/core.dart';
import 'package:flutter/cupertino.dart';

import 'package:groups/src/group_details/bloc/group_details_bloc.dart';
import 'package:groups/src/group_details/ui/widgets/action_primary_button.dart';
import 'package:groups/src/group_details/ui/widgets/action_secondary_button.dart';

class GroupDetailsActions extends StatelessWidget {
  const GroupDetailsActions({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GroupDetailsBloc, GroupDetailsState>(
      builder: (_, GroupDetailsState state) {
        final Widget primaryButton;
        final Widget secondaryButton;

        if (state.isInvitation) {
          primaryButton = ActionPrimaryButton(
            labelKey: 'groupDetailsScreen.joinButton',
            onTap: _onJoinButtonPressed,
          );
          secondaryButton = ActionSecondaryButton(
            labelKey: 'groupDetailsScreen.declineButton',
            onTap: _onDeclineButtonPressed,
          );
        } else {
          primaryButton = ActionPrimaryButton(
            labelKey: 'groupDetailsScreen.inviteMembersButton',
            onTap: _onInviteMembersButtonPressed,
          );
          secondaryButton = ActionSecondaryButton(
            labelKey: 'groupDetailsScreen.leaveButton',
            onTap: _onLeaveButtonPressed,
          );
        }

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            children: <Widget>[
              Expanded(
                flex: 7,
                child: secondaryButton,
              ),
              const SizedBox(width: 8),
              Expanded(
                flex: 13,
                child: primaryButton,
              ),
            ],
          ),
        );
      },
    );
  }

  void _onLeaveButtonPressed(BuildContext context) {
    BlocProvider.of<GroupDetailsBloc>(context).add(const LeaveGroup());
  }

  void _onInviteMembersButtonPressed(BuildContext context) {
    BlocProvider.of<GroupDetailsBloc>(context).add(const InviteMembers());
  }

  void _onDeclineButtonPressed(BuildContext context) {
    BlocProvider.of<GroupDetailsBloc>(context).add(const DeclineInvitation());
  }

  void _onJoinButtonPressed(BuildContext context) {
    BlocProvider.of<GroupDetailsBloc>(context).add(const JoinGroup());
  }
}
