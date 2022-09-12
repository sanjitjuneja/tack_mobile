import 'dart:async';

import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:domain/domain.dart';
import 'package:domain/use_case.dart';

part 'groups_event.dart';

part 'groups_state.dart';

class GroupsBloc extends Bloc<GroupsEvent, GroupsState> {
  final LoadGroupsUseCase _loadGroupsUseCase;
  final ObserveGroupIntentUseCase _observeGroupIntentUseCase;

  late StreamSubscription<WebSocketIntent<GroupDetails>>
      _groupIntentSubscription;

  GroupsBloc({
    required LoadGroupsUseCase loadGroupsUseCase,
    required ObserveGroupIntentUseCase observeGroupIntentUseCase,
  })  : _loadGroupsUseCase = loadGroupsUseCase,
        _observeGroupIntentUseCase = observeGroupIntentUseCase,
        super(
          GroupsState(
            isLoading: true,
          ),
        ) {
    on<InitialLoad>(_onInitialLoad);
    on<RefreshAction>(_onRefreshAction);
    on<LoadMoreAction>(_onLoadMoreAction);

    on<GroupIntentAction>(_onGroupIntentAction);

    _groupIntentSubscription = _observeGroupIntentUseCase
        .execute(NoParams())
        .listen((WebSocketIntent<GroupDetails> groupIntent) {
      add(GroupIntentAction(groupIntent: groupIntent));
    });

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

  Future<void> _onGroupIntentAction(
    GroupIntentAction event,
    Emitter<GroupsState> emit,
  ) async {
    final WebSocketIntent<GroupDetails> intent = event.groupIntent;

    final PaginationModel<GroupDetails> groupsData;

    switch (intent.action) {
      case WebSocketAction.create:
        groupsData = state.groupsData.addItem(
          item: intent.object!,
        );
        break;
      case WebSocketAction.update:
        groupsData = state.groupsData.updateItem(
          item: intent.object!,
        );
        break;
      case WebSocketAction.delete:
        groupsData = state.groupsData.removeItem(
          itemId: intent.objectId,
        );
        break;
    }

    emit(
      state.copyWith(groupsData: groupsData),
    );
  }

  @override
  Future<void> close() async {
    _groupIntentSubscription.cancel();

    return super.close();
  }
}
