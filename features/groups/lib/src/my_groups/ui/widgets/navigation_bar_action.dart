import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:flutter/cupertino.dart';
import 'package:groups/src/my_groups/bloc/my_groups_bloc.dart';

class NavigationBarAction extends StatelessWidget {
  const NavigationBarAction({super.key});

  @override
  Widget build(BuildContext context) {
    return NavigationBarActionButton(
      labelKey: 'groupsScreen.myInvitationsButton',
      withFeedback: true,
      type: ButtonType.primary,
      withShadow: true,
      withBorder: true,
      horizontalPadding: 22.0,
      onTap: _onInvitationsButtonPressed,
    );
  }

  void _onInvitationsButtonPressed(BuildContext context) {
    BlocProvider.of<MyGroupsBloc>(context).add(OpenMyInvitations());
  }
}
