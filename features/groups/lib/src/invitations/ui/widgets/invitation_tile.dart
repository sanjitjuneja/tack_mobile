import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:domain/domain.dart';
import 'package:flutter/cupertino.dart';

import 'package:groups/src/invitations/bloc/invitations_bloc.dart';

class InvitationTile extends StatelessWidget {
  final GroupInvitation invitation;

  const InvitationTile({
    super.key,
    required this.invitation,
  });

  @override
  Widget build(BuildContext context) {
    return OpacityOnTapContainer(
      onTap: () => _onTilePressed(context),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14.0, horizontal: 16.0),
        decoration: BoxDecoration(
          color: AppTheme.primaryColor,
          borderRadius: BorderRadius.circular(16.0),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: AppTheme.shadowColor,
              offset: const Offset(0, 4),
              blurRadius: 4,
            ),
          ],
        ),
        child: Row(
          children: <Widget>[
            AppNetworkImageWidget(
              invitation.group.imageUrl,
              placeholderIcon: null,
              isShadowBorder: false,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    invitation.group.name,
                    style: AppTextTheme.manrope16Bold
                        .copyWith(color: AppTheme.textPrimaryColor),
                  ),
                  const SizedBox(height: 6),
                  AppButton(
                    labelKey: 'invitationsScreen.viewInviteButton',
                    padding: const EdgeInsets.symmetric(
                      vertical: 5.0,
                      horizontal: 20.0,
                    ),
                    type: ButtonType.secondary,
                    borderColor: AppTheme.buttonLightBorderColor,
                    expanded: false,
                    onTap: () => _onGroupInfoButtonPressed(context),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 2),
            AppButton(
              labelKey: 'invitationsScreen.joinGroupButton',
              padding: const EdgeInsets.symmetric(
                horizontal: 28.0,
                vertical: 8.0,
              ),
              expanded: false,
              onTap: () => _onJoinButtonPressed(context),
            ),
          ],
        ),
      ),
    );
  }

  void _onTilePressed(BuildContext context) {
    BlocProvider.of<InvitationsBloc>(context)
        .add(OpenInvitationDetails(invitation: invitation));
  }

  void _onGroupInfoButtonPressed(BuildContext context) {
    BlocProvider.of<InvitationsBloc>(context)
        .add(OpenInvitationDetails(invitation: invitation));
  }

  void _onJoinButtonPressed(BuildContext context) {
    BlocProvider.of<InvitationsBloc>(context)
        .add(JoinGroup(invitation: invitation));
  }
}
