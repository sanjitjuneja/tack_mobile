import 'package:core/core.dart';
import 'package:domain/domain.dart';
import 'package:flutter/cupertino.dart';
import 'package:navigation/navigation.dart';

import '../bloc/invite_members_bloc.dart';
import 'invite_members_screen.dart';

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
            fetchGroupInviteLinkUseCase:
                appLocator.get<FetchGroupInviteLinkUseCase>(),
            createDeeplinkUseCase: appLocator.get<CreateDeeplinkUseCase>(),
          );
        },
        child: const InviteMembersScreen(),
      ),
    );
  }
}
