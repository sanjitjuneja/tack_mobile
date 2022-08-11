import 'dart:async';

import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:domain/domain.dart';
import 'package:groups/src/group_details/ui/group_details_page.dart';
import 'package:navigation/navigation.dart';

import '../../../groups.dart';

part 'groups_event.dart';

part 'groups_state.dart';

class GroupsBloc extends Bloc<GroupsEvent, GroupsState> {
  final AppRouterDelegate _appRouter;
  final LoadGroupsUseCase _loadGroupsUseCase;

  GroupsBloc({
    required AppRouterDelegate appRouter,
    required LoadGroupsUseCase loadGroupsUseCase,
  })  : _appRouter = appRouter,
        _loadGroupsUseCase = loadGroupsUseCase,
        super(const GroupsState()) {
    on<InitialLoad>(_onInitialLoad);
    on<RefreshAction>(_onRefreshAction);
    on<LoadMoreAction>(_onLoadMoreAction);

    on<OpenGroupDetails>(_onOpenGroupDetails);
    on<InviteMembers>(_onInviteMembers);

    on<OpenMyInvitations>(_onOpenMyInvitations);
    on<CreateGroup>(_onCreateGroup);

    add(const InitialLoad());
  }

  Future<void> _onInitialLoad(
    InitialLoad event,
    Emitter<GroupsState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));
    add(const RefreshAction());
  }

  Future<void> _onRefreshAction(
    RefreshAction event,
    Emitter<GroupsState> emit,
  ) async {
    try {
      final List<Group> groups =
          await _loadGroupsUseCase.execute(const GetGroupsPayload());

      event.completer?.complete(RefreshingStatus.complete);
      emit(state.copyWith(groups: groups));
    } catch (e) {
      event.completer?.complete(RefreshingStatus.failed);
      if (event.completer == null) {
        emit(state.copyWith(groups: <Group>[]));
      }
    }
  }

  Future<void> _onLoadMoreAction(
    LoadMoreAction event,
    Emitter<GroupsState> emit,
  ) async {
    try {
      final List<Group> groups =
          await _loadGroupsUseCase.execute(const GetGroupsPayload());

      event.completer.complete(LoadingStatus.complete);
      emit(state.copyWith(groups: groups));
    } catch (e) {
      event.completer.complete(LoadingStatus.failed);
    }
  }

  Future<void> _onOpenGroupDetails(
    OpenGroupDetails event,
    Emitter<GroupsState> emit,
  ) async {
    _appRouter.push(GroupDetailsFeature.groupPage(group: event.group));
  }

  Future<void> _onInviteMembers(
    InviteMembers event,
    Emitter<GroupsState> emit,
  ) async {
    _appRouter.push(InviteMembersFeature.page(group: event.group));
  }

  Future<void> _onOpenMyInvitations(
    OpenMyInvitations event,
    Emitter<GroupsState> emit,
  ) async {
    _appRouter.push(InvitationsFeature.page());
  }

  Future<void> _onCreateGroup(
    CreateGroup event,
    Emitter<GroupsState> emit,
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
            AlertPropertyKey.message: <String, String>{'groupName': group.name},
          },
        ),
      ),
    );

    if (shouldInviteMember) add(InviteMembers(group: group));
  }
}
