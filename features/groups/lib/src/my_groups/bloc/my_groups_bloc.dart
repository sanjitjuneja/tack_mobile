import 'dart:async';

import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:domain/domain.dart';
import 'package:navigation/navigation.dart';

import '../../create_group/ui/create_group_page.dart';
import '../../group_details/models/group_details_screen_result.dart';
import '../../group_details/ui/group_details_page.dart';
import '../../invitations/ui/invitations_page.dart';
import '../../invite_members/ui/invite_members_page.dart';

part 'my_groups_event.dart';

part 'my_groups_state.dart';

class MyGroupsBloc extends Bloc<MyGroupsEvent, MyGroupsState> {
  final AppRouterDelegate _appRouter;

  MyGroupsBloc({
    required AppRouterDelegate appRouter,
  })  : _appRouter = appRouter,
        super(const MyGroupsState()) {
    on<OpenGroupDetails>(_onOpenGroupDetails);
    on<InviteMembers>(_onInviteMembers);

    on<OpenMyInvitations>(_onOpenMyInvitations);
    on<CreateGroup>(_onCreateGroup);
  }

  Future<void> _onOpenGroupDetails(
    OpenGroupDetails event,
    Emitter<MyGroupsState> emit,
  ) async {
    final GroupDetailsScreenResult? result = await _appRouter.pushForResult(
      GroupDetailsFeature.groupPage(group: event.group),
    );

    __onResult(
      result: result,
      groupName: event.group.name,
    );
  }

  Future<void> _onInviteMembers(
    InviteMembers event,
    Emitter<MyGroupsState> emit,
  ) async {
    _appRouter.push(
      InviteMembersFeature.page(
        group: event.group,
      ),
    );
  }

  Future<void> _onOpenMyInvitations(
    OpenMyInvitations event,
    Emitter<MyGroupsState> emit,
  ) async {
    _appRouter.push(InvitationsFeature.page());
  }

  Future<void> _onCreateGroup(
    CreateGroup event,
    Emitter<MyGroupsState> emit,
  ) async {
    final Group? group = await _appRouter.pushForResult(
      CreateGroupFeature.page(),
    );

    if (group == null) return;

    final bool shouldInviteMember = await _appRouter.pushForResult(
      AppAlertDialog.page(
        SuccessAlert(
          contentKey: 'otherAlert.groupCreated',
          translationParams: <AlertPropertyKey, Map<String, String>>{
            AlertPropertyKey.message: <String, String>{
              'groupName': group.name,
            },
          },
        ),
      ),
    );

    if (shouldInviteMember) add(InviteMembers(group: group));
  }

  Future<void> __onResult({
    required GroupDetailsScreenResult? result,
    required String groupName,
  }) async {
    final TranslationParams translationParams =
        <AlertPropertyKey, Map<String, String>>{
      AlertPropertyKey.message: <String, String>{
        'groupName': groupName,
      },
    };

    switch (result) {
      case GroupDetailsScreenResult.leaveGroup:
        _appRouter.pushForResult(
          AppAlertDialog.page(
            SuccessAlert(
              contentKey: 'otherAlert.noMoreGroupMember',
              translationParams: translationParams,
            ),
          ),
        );
        break;
      default:
        return;
    }
  }
}
