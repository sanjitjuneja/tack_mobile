import 'package:core/core.dart';
import 'package:domain/domain.dart';
import 'package:flutter/cupertino.dart';
import 'package:navigation/navigation.dart';

import 'package:groups/src/invite_members/bloc/invite_members_bloc.dart';
import 'package:groups/src/invite_members/ui/invite_members_screen.dart';

class InviteMembersFeature {
  static const String routeName = '/inviteMembers';

  static Page<void> page({
    required Group group,
  }) {
    return _InviteMembersPage(group: group);
  }
}

class _InviteMembersPage extends Page<void> {
  final Group group;

  @override
  String get name => InviteMembersFeature.routeName;

  const _InviteMembersPage({
    required this.group,
  });

  @override
  Route<void> createRoute(BuildContext context) {
    return CupertinoPageRoute<void>(
      settings: this,
      builder: (_) => BlocProvider<InviteMembersBloc>(
        create: (_) {
          return InviteMembersBloc(
            group: group,
            appRouter: AppRouter.of(context),
            loadGroupInviteLinkUseCase:
                appLocator.get<LoadGroupInviteLinkUseCase>(),
            createDeeplinkUseCase: appLocator.get<CreateDeeplinkUseCase>(),
          );
        },
        child: const InviteMembersScreen(),
      ),
    );
  }
}
