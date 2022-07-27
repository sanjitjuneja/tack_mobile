import 'dart:async';

import 'package:core/core.dart';
import 'package:domain/groups/groups.dart';
import 'package:domain/models/verification_data.dart';
import 'package:navigation/navigation.dart';

import '../../../groups.dart';
import 'groups_event.dart';
import 'groups_state.dart';

class GroupsBloc extends Bloc<GroupsEvent, GroupsState> {
  final AppRouterDelegate appRouter;

  GroupsBloc({
    required this.appRouter,
  }) : super(GroupsLoading()) {
    add(
      GroupsLoadData(),
    );
  }

  VerificationData? verificationData;

  @override
  Stream<GroupsState> mapEventToState(GroupsEvent event) async* {
    if (event is GroupsLoadData) {}

    if (event is OpenMyInvitations) {
      appRouter.push(
        Invitations.page(),
      );
    }

    if (event is OpenGroupDetails) {
      appRouter.push(
        InvitationDetails.page(),
      );
    }

    if (event is OnInviteMembers) {}

    if (event is OnCreateGroup) {
      final Group? group = await appRouter.pushForResult(
        CreateGroup.page(),
      );

      if (group != null) {}
    }
  }
}
