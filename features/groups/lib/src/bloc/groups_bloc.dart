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
          GroupsState(
            isLoading: true,
          ),
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
      final PaginationModel<GroupDetails> groupsData =
          await _loadGroupsUseCase.execute(const FetchGroupsPayload());

      event.completer?.complete(RefreshingStatus.complete);
      emit(
        state.copyWith(groupsData: groupsData),
      );
    } catch (e) {
      event.completer?.complete(RefreshingStatus.failed);
      if (event.completer == null) {
        emit(
          state.copyWith(
            groupsData: PaginationModel.empty(),
          ),
        );
      }
    }
  }

  Future<void> _onLoadMoreAction(
    LoadMoreAction event,
    Emitter<GroupsState> emit,
  ) async {
    try {
      final PaginationModel<GroupDetails> groupsData =
          await _loadGroupsUseCase.execute(
        FetchGroupsPayload(
          lastObjectId: state.groupsData.results.lastOrNull?.id,
          nextPage: state.groupsData.next,
        ),
      );

      event.completer.complete(LoadingStatus.complete);
      emit(
        state.copyWith(
          groupsData: state.groupsData.more(
            newPage: groupsData,
          ),
        ),
      );
    } catch (e) {
      event.completer.complete(LoadingStatus.failed);
    }
  }
}
