import 'package:core/core.dart';
import 'package:core/di/app_di.dart';
import 'package:domain/domain.dart';
import 'package:flutter/cupertino.dart';

import 'package:groups/src/invite_members/bloc/invite_members_bloc.dart';
import 'package:groups/src/invite_members/ui/invite_members_screen.dart';
import 'package:navigation/navigation.dart';

class InviteMembers {
  static const String routeName = '/inviteMembers';

  static Page<void> page() {
    return const _InviteMembersPage();
  }
}

class _InviteMembersPage extends Page<void> {
  @override
  String get name => InviteMembers.routeName;

  const _InviteMembersPage();

  @override
  Route<void> createRoute(BuildContext context) {
    return CupertinoPageRoute<void>(
      settings: this,
      builder: (_) => BlocProvider<InviteMembersBloc>(
        create: (_) {
          return InviteMembersBloc(
            appRouter: appLocator.get<AppRouterDelegate>(),
          );
        },
        child: const InviteMembersScreen(),
      ),
    );
  }
}
