import 'dart:async';

import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:domain/domain.dart';
import 'package:navigation/navigation.dart';

import '../models/group_details_screen_result.dart';
import '../../invite_members/ui/invite_members_page.dart';

part 'group_details_event.dart';

part 'group_details_state.dart';

class GroupDetailsBloc extends Bloc<GroupDetailsEvent, GroupDetailsState> {
  final AppRouterDelegate _appRouter;
  final FetchGroupMembersUseCase _fetchGroupMembersUseCase;
  final AcceptGroupInvitationUseCase _acceptGroupInvitationUseCase;
  final DeclineGroupInvitationUseCase _declineGroupInvitationUseCase;
  final LeaveGroupUseCase _leaveGroupUseCase;
  final MuteGroupUseCase _muteGroupUseCase;
  final UnMuteGroupUseCase _unMuteGroupUseCase;

  GroupDetailsBloc({
    required AppRouterDelegate appRouter,
    required FetchGroupMembersUseCase fetchGroupMembersUseCase,
    required AcceptGroupInvitationUseCase acceptGroupInvitationUseCase,
    required DeclineGroupInvitationUseCase declineGroupInvitationUseCase,
    required LeaveGroupUseCase leaveGroupUseCase,
    required MuteGroupUseCase muteGroupUseCase,
    required UnMuteGroupUseCase unMuteGroupUseCase,
    required GroupDetails? groupDetails,
    required GroupInvitation? groupInvitation,
  })  : _appRouter = appRouter,
        _fetchGroupMembersUseCase = fetchGroupMembersUseCase,
        _acceptGroupInvitationUseCase = acceptGroupInvitationUseCase,
        _declineGroupInvitationUseCase = declineGroupInvitationUseCase,
        _leaveGroupUseCase = leaveGroupUseCase,
        _muteGroupUseCase = muteGroupUseCase,
        _unMuteGroupUseCase = unMuteGroupUseCase,
        super(
          GroupDetailsState(
            groupDetails: groupDetails,
            invitation: groupInvitation,
            isLoading: true,
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
    add(const RefreshAction());
  }

  Future<void> _onRefreshAction(
    RefreshAction event,
    Emitter<GroupDetailsState> emit,
  ) async {
    try {
      final PaginationModel<TackUser> membersData =
          await _fetchGroupMembersUseCase.execute(
        FetchGroupMembersPayload(
          group: state.group,
        ),
      );

      event.completer?.complete(RefreshingStatus.complete);
      emit(
        state.copyWith(
          membersData: membersData,
        ),
      );
    } catch (e) {
      event.completer?.complete(RefreshingStatus.failed);

      if (event.completer == null) {
        emit(
          state.copyWith(
            membersData: PaginationModel.empty(),
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
      final PaginationModel<TackUser> membersData =
          await _fetchGroupMembersUseCase.execute(
        FetchGroupMembersPayload(
          group: state.group,
          lastObjectId: state.membersData.results.lastOrNull?.id,
          nextPage: state.membersData.next,
        ),
      );

      event.completer.complete(LoadingStatus.complete);
      emit(
        state.copyWith(
          membersData: state.membersData.more(
            newPage: membersData,
          ),
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
    } on HasOngoingGroupTacksException catch (e) {
      _appRouter.pop();
      _appRouter.pushForResult(
        AppAlertDialog.page(
          ErrorAlert(
            messageKey: e.messageKey,
          ),
        ),
      );
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
      final GroupDetails groupDetails;

      if (state.groupDetails!.isMuted) {
        groupDetails = await _unMuteGroupUseCase.execute(
          UnMuteGroupPayload(group: state.group),
        );
      } else {
        groupDetails = await _muteGroupUseCase.execute(
          MuteGroupPayload(group: state.group),
        );
      }
      _appRouter.pop();

      emit(
        state.copyWith(
          groupDetails: groupDetails,
        ),
      );
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
