import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:flutter/cupertino.dart';

import 'package:groups/src/group_details/bloc/group_details_bloc.dart';

class GroupDetailsNavigationBarAction extends StatelessWidget {
  const GroupDetailsNavigationBarAction({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GroupDetailsBloc, GroupDetailsState>(
      builder: (_, GroupDetailsState state) {
        if (state.isInvitation) {
          return NavigationBarActionButton(
            labelKey: 'groupDetailsScreen.joinButton',
            type: ButtonType.primary,
            horizontalPadding: 30.0,
            onTap: _onJoinButtonPressed,
          );
        } else {
          final String labelKey;
          final AppIcon icon;
          if (state.groupDetails!.isMuted) {
            labelKey = 'groupDetailsScreen.unMuteNotificationsButton';
            icon = AppIconsTheme.bell;
          } else {
            labelKey = 'groupDetailsScreen.muteNotificationsButton';
            icon = AppIconsTheme.bellCrossedOut;
          }

          return ConstrainedBox(
            constraints: const BoxConstraints(minWidth: 110),
            child: NavigationBarActionButton(
              labelKey: labelKey,
              icon: icon,
              onTap: _onChangeNotificationsSettingsButtonPressed,
            ),
          );
        }
      },
    );
  }

  void _onChangeNotificationsSettingsButtonPressed(BuildContext context) {
    BlocProvider.of<GroupDetailsBloc>(context)
        .add(const ChangeNotificationsSettings());
  }

  void _onJoinButtonPressed(BuildContext context) {
    BlocProvider.of<GroupDetailsBloc>(context).add(const JoinGroup());
  }
}
