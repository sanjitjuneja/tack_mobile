import 'package:core/core.dart';
import 'package:domain/domain.dart';
import 'package:flutter/cupertino.dart';
import 'package:navigation/navigation.dart';

import '../models/group_details_screen_result.dart';
import '../bloc/group_details_bloc.dart';
import 'group_details_screen.dart';

class GroupDetailsFeature {
  static const String routeName = '/groupDetails';

  static Page<GroupDetailsScreenResult?> groupPage({
    required GroupDetails groupDetails,
  }) {
    return _GroupDetailsPage(
      groupDetails: groupDetails,
    );
  }

  static Page<GroupDetailsScreenResult?> groupInvitationPage({
    required GroupInvitation invitation,
  }) {
    return _GroupDetailsPage(
      groupInvitation: invitation,
    );
  }
}

class _GroupDetailsPage extends Page<GroupDetailsScreenResult?> {
  final GroupDetails? groupDetails;
  final GroupInvitation? groupInvitation;

  @override
  String get name => GroupDetailsFeature.routeName;

  const _GroupDetailsPage({
    this.groupDetails,
    this.groupInvitation,
  }) : assert(groupDetails != null || groupInvitation != null);

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
            groupDetails: groupDetails,
            groupInvitation: groupInvitation,
          );
        },
        child: const GroupDetailsScreen(),
      ),
    );
  }
}
