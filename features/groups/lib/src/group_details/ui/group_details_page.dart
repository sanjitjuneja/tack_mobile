import 'package:core/core.dart';
import 'package:domain/domain.dart';
import 'package:flutter/cupertino.dart';
import 'package:navigation/navigation.dart';

import 'package:groups/src/group_details/models/group_details_screen_result.dart';
import 'package:groups/src/group_details/bloc/group_details_bloc.dart';
import 'package:groups/src/group_details/ui/group_details_screen.dart';

class GroupDetailsFeature {
  static const String routeName = '/groupDetails';

  static Page<GroupDetailsScreenResult?> groupPage({
    required Group group,
  }) {
    return _GroupDetailsPage(group: group);
  }

  static Page<GroupDetailsScreenResult?> groupInvitationPage({
    required GroupInvitation invitation,
  }) {
    return _GroupDetailsPage(
      group: invitation.group,
      groupInvitation: invitation,
    );
  }
}

class _GroupDetailsPage extends Page<GroupDetailsScreenResult?> {
  final Group group;
  final GroupInvitation? groupInvitation;

  @override
  String get name => GroupDetailsFeature.routeName;

  const _GroupDetailsPage({
    required this.group,
    this.groupInvitation,
  });

  @override
  Route<GroupDetailsScreenResult?> createRoute(BuildContext context) {
    return CupertinoPageRoute<GroupDetailsScreenResult?>(
      settings: this,
      builder: (_) => BlocProvider<GroupDetailsBloc>(
        create: (_) {
          return GroupDetailsBloc(
            appRouter: AppRouter.of(context),
            loadGroupMembersUseCase: appLocator.get<LoadGroupMembersUseCase>(),
            acceptGroupInvitationUseCase:
                appLocator.get<AcceptGroupInvitationUseCase>(),
            declineGroupInvitationUseCase:
                appLocator.get<DeclineGroupInvitationUseCase>(),
            leaveGroupUseCase: appLocator.get<LeaveGroupUseCase>(),
            muteGroupUseCase: appLocator.get<MuteGroupUseCase>(),
            unMuteGroupUseCase: appLocator.get<UnMuteGroupUseCase>(),
            group: group,
            groupInvitation: groupInvitation,
          );
        },
        child: const GroupDetailsScreen(),
      ),
    );
  }
}
