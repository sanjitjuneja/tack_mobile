import 'dart:async';

import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:domain/domain.dart';
import 'package:navigation/navigation.dart';

import 'package:groups/src/group_details/models/group_details_screen_result.dart';
import 'package:groups/src/group_details/models/group_users_state.dart';
import 'package:groups/src/invite_members/ui/invite_members_page.dart';

part 'group_details_event.dart';

part 'group_details_state.dart';

class GroupDetailsBloc extends Bloc<GroupDetailsEvent, GroupDetailsState> {
  final AppRouterDelegate _appRouter;
  final LoadGroupMembersUseCase _loadGroupMembersUseCase;
  final AcceptGroupInvitationUseCase _acceptGroupInvitationUseCase;
  final DeclineGroupInvitationUseCase _declineGroupInvitationUseCase;
  final LeaveGroupUseCase _leaveGroupUseCase;
  final MuteGroupUseCase _muteGroupUseCase;
  final UnMuteGroupUseCase _unMuteGroupUseCase;

  GroupDetailsBloc({
    required AppRouterDelegate appRouter,
    required LoadGroupMembersUseCase loadGroupMembersUseCase,
    required AcceptGroupInvitationUseCase acceptGroupInvitationUseCase,
    required DeclineGroupInvitationUseCase declineGroupInvitationUseCase,
    required LeaveGroupUseCase leaveGroupUseCase,
    required MuteGroupUseCase muteGroupUseCase,
    required UnMuteGroupUseCase unMuteGroupUseCase,
    required Group group,
    GroupInvitation? groupInvitation,
  })  : _appRouter = appRouter,
        _loadGroupMembersUseCase = loadGroupMembersUseCase,
        _acceptGroupInvitationUseCase = acceptGroupInvitationUseCase,
        _declineGroupInvitationUseCase = declineGroupInvitationUseCase,
        _leaveGroupUseCase = leaveGroupUseCase,
        _muteGroupUseCase = muteGroupUseCase,
        _unMuteGroupUseCase = unMuteGroupUseCase,
        super(
          GroupDetailsState(
            group: group,
            invitation: groupInvitation,
          ),
        ) {
    on<InitialLoad>(_onInitialLoad);
    on<RefreshAction>(_onRefreshAction);
    on<LoadMoreAction>(_onLoadMoreAction);

    on<JoinGroup>(_onJoinGroup);
    on<DeclineInvitation>(_onDeclineInvitation);
    on<LeaveGroup>(_onLeaveGroup);
    on<ChangeNotificationsSettings>(_onChangeNotificationsSettings);
    on<InviteMembers>(_onInviteMembers);

    add(const InitialLoad());
  }

  Future<void> _onInitialLoad(
    InitialLoad event,
    Emitter<GroupDetailsState> emit,
  ) async {
    emit(
      state.copyWith(
        usersState: state.usersState.copyWith(isLoading: true),
      ),
    );
    add(const RefreshAction());
  }

  Future<void> _onRefreshAction(
    RefreshAction event,
    Emitter<GroupDetailsState> emit,
  ) async {
    try {
      final List<TackUser> members = await _loadGroupMembersUseCase.execute(
        GetGroupMembersPayload(group: state.group),
      );

      event.completer?.complete(RefreshingStatus.complete);
      emit(
        state.copyWith(
          usersState: state.usersState.copyWith(members: members),
        ),
      );
    } catch (e) {
      event.completer?.complete(RefreshingStatus.failed);

      if (event.completer == null) {
        emit(
          state.copyWith(
            usersState: const GroupsUsersState(),
          ),
        );
      }
    }
  }

  Future<void> _onLoadMoreAction(
    LoadMoreAction event,
    Emitter<GroupDetailsState> emit,
  ) async {
    try {
      final List<TackUser> members = await _loadGroupMembersUseCase.execute(
        GetGroupMembersPayload(group: state.group),
      );

      event.completer.complete(LoadingStatus.complete);
      emit(
        state.copyWith(
          usersState: state.usersState.copyWith(members: members),
        ),
      );
    } catch (e) {
      event.completer.complete(LoadingStatus.failed);
    }
  }

  Future<void> _onJoinGroup(
    JoinGroup event,
    Emitter<GroupDetailsState> emit,
  ) async {
    if (!state.isInvitation) return;

    _appRouter.push(ProgressDialog.page());
    try {
      await _acceptGroupInvitationUseCase.execute(
        AcceptGroupInvitationPayload(
          invitation: state.invitation!,
        ),
      );
      _appRouter.pop();
      _appRouter.popWithResult(GroupDetailsScreenResult.joinGroup);
    } catch (e) {
      _appRouter.pop();
      _appRouter.pushForResult(
        AppAlertDialog.page(
          ErrorAlert(
            messageKey: e.toString(),
          ),
        ),
      );
    }
  }

  Future<void> _onDeclineInvitation(
    DeclineInvitation event,
    Emitter<GroupDetailsState> emit,
  ) async {
    if (!state.isInvitation) return;

    final bool result = await _appRouter.pushForResult(
      DestructiveDialog.page(
        DestructiveAlert(
          contentKey: 'destructiveAlert.declineGroupInvite',
          translationParams: <AlertPropertyKey, Map<String, String>>{
            AlertPropertyKey.message: <String, String>{
              'groupName': state.group.name,
            }
          },
        ),
      ),
    );

    if (!result) return;

    _appRouter.push(ProgressDialog.page());
    try {
      await _declineGroupInvitationUseCase.execute(
        DeclineGroupInvitationPayload(
          invitation: state.invitation!,
        ),
      );
      _appRouter.pop();
      _appRouter.popWithResult(GroupDetailsScreenResult.declineInvitation);
    } catch (e) {
      _appRouter.pop();
      _appRouter.pushForResult(
        AppAlertDialog.page(
          ErrorAlert(
            messageKey: e.toString(),
          ),
        ),
      );
    }
  }

  Future<void> _onLeaveGroup(
    LeaveGroup event,
    Emitter<GroupDetailsState> emit,
  ) async {
    if (state.isInvitation) return;

    final bool result = await _appRouter.pushForResult(
      DestructiveDialog.page(
        DestructiveAlert(
          contentKey: 'destructiveAlert.leaveGroup',
          translationParams: <AlertPropertyKey, Map<String, String>>{
            AlertPropertyKey.message: <String, String>{
              'groupName': state.group.name,
            }
          },
        ),
      ),
    );

    if (!result) return;

    _appRouter.push(ProgressDialog.page());
    try {
      await _leaveGroupUseCase.execute(
        LeaveGroupPayload(
          group: state.group,
        ),
      );
      _appRouter.pop();
      _appRouter.popWithResult(GroupDetailsScreenResult.leaveGroup);
    } catch (e) {
      _appRouter.pop();
      _appRouter.pushForResult(
        AppAlertDialog.page(
          ErrorAlert(
            messageKey: e.toString(),
          ),
        ),
      );
    }
  }

  Future<void> _onChangeNotificationsSettings(
    ChangeNotificationsSettings event,
    Emitter<GroupDetailsState> emit,
  ) async {
    if (state.isInvitation) return;

    _appRouter.push(ProgressDialog.page());
    try {
      final Group group;

      if (state.group.isMuted) {
        group = await _unMuteGroupUseCase.execute(
          UnMuteGroupPayload(group: state.group),
        );
      } else {
        group = await _muteGroupUseCase.execute(
          MuteGroupPayload(group: state.group),
        );
      }
      _appRouter.pop();

      emit(state.copyWith(group: group));
    } catch (e) {
      _appRouter.pop();
      _appRouter.pushForResult(
        AppAlertDialog.page(
          ErrorAlert(
            messageKey: e.toString(),
          ),
        ),
      );
    }
  }

  Future<void> _onInviteMembers(
    InviteMembers event,
    Emitter<GroupDetailsState> emit,
  ) async {
    _appRouter.push(InviteMembersFeature.page(group: state.group));
  }
}
