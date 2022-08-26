import 'dart:async';

import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:domain/domain.dart';

part 'groups_event.dart';

part 'groups_state.dart';

class GroupsBloc extends Bloc<GroupsEvent, GroupsState> {
  final LoadGroupsUseCase _loadGroupsUseCase;

  GroupsBloc({
    required LoadGroupsUseCase loadGroupsUseCase,
  })  : _loadGroupsUseCase = loadGroupsUseCase,
        super(
          const GroupsState(isLoading: true),
        ) {
    on<InitialLoad>(_onInitialLoad);
    on<RefreshAction>(_onRefreshAction);
    on<LoadMoreAction>(_onLoadMoreAction);

    add(const InitialLoad());
  }

  Future<void> _onInitialLoad(
    InitialLoad event,
    Emitter<GroupsState> emit,
  ) async {
    add(const RefreshAction());
  }

  Future<void> _onRefreshAction(
    RefreshAction event,
    Emitter<GroupsState> emit,
  ) async {
    try {
      final List<GroupDetails> groups =
          await _loadGroupsUseCase.execute(const GetGroupsPayload());

      event.completer?.complete(RefreshingStatus.complete);
      emit(
        state.copyWith(groups: groups),
      );
    } catch (e) {
      event.completer?.complete(RefreshingStatus.failed);
      if (event.completer == null) {
        emit(
          state.copyWith(groups: <GroupDetails>[]),
        );
      }
    }
  }

  Future<void> _onLoadMoreAction(
    LoadMoreAction event,
    Emitter<GroupsState> emit,
  ) async {
    try {
      final List<GroupDetails> groups = await _loadGroupsUseCase.execute(
        const GetGroupsPayload(),
      );

      event.completer.complete(LoadingStatus.complete);
      emit(state.copyWith(groups: groups));
    } catch (e) {
      event.completer.complete(LoadingStatus.failed);
    }
  }
}
