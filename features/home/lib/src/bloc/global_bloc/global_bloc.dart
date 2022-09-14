import 'dart:async';

import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:domain/domain.dart';
import 'package:domain/use_case.dart';
import 'package:groups/groups.dart';
import 'package:navigation/navigation.dart';

part 'global_event.dart';

part 'global_state.dart';

class GlobalBloc extends Bloc<GlobalEvent, GlobalState> {
  final AppRouterDelegate _appRouter;
  final ObserveUserUseCase _observeUserUseCase;
  final ObserveCurrentGroupUseCase _observeCurrentGroupUseCase;
  final ObserveGroupsCountUseCase _observeGroupsCountUseCase;
  final ObserveCompletedTackRunnerIntentUseCase
      _observeCompletedTackRunnerIntentUseCase;
  final ObserveCancelTackerTackRunnerIntentUseCase
      _observeCancelTackerTackRunnerIntentUseCase;
  final FetchGroupUseCase _fetchGroupUseCase;
  final SelectGroupUseCase _selectGroupUseCase;

  late StreamSubscription<User> _userSubscription;
  late StreamSubscription<Group?> _currentGroupSubscription;
  late StreamSubscription<int> _groupsCountSubscription;

  late StreamSubscription<WebSocketIntent<Tack>>
      _completedRackRunnerIntentSubscription;
  late StreamSubscription<WebSocketIntent<Tack>>
      _cancelTackerTackRunnerIntentSubscription;

  GlobalBloc({
    required AppRouterDelegate appRouter,
    required GetCurrentUserUseCase getCurrentUserUseCase,
    required ObserveUserUseCase observeUserUseCase,
    required GetCurrentGroupUseCase getCurrentGroupUseCase,
    required GetGroupsCountUseCase getGroupsCountUseCase,
    required ObserveCurrentGroupUseCase observeCurrentGroupUseCase,
    required ObserveGroupsCountUseCase observeGroupsCountUseCase,
    required ObserveCompletedTackRunnerIntentUseCase
        observeCompletedTackRunnerIntentUseCase,
    required ObserveCancelTackerTackRunnerIntentUseCase
        observeCancelTackerTackRunnerIntentUseCase,
    required FetchGroupUseCase fetchGroupUseCase,
    required SelectGroupUseCase selectGroupUseCase,
  })  : _appRouter = appRouter,
        _observeUserUseCase = observeUserUseCase,
        _observeCurrentGroupUseCase = observeCurrentGroupUseCase,
        _observeGroupsCountUseCase = observeGroupsCountUseCase,
        _observeCompletedTackRunnerIntentUseCase =
            observeCompletedTackRunnerIntentUseCase,
        _observeCancelTackerTackRunnerIntentUseCase =
            observeCancelTackerTackRunnerIntentUseCase,
        _fetchGroupUseCase = fetchGroupUseCase,
        _selectGroupUseCase = selectGroupUseCase,
        super(
          GlobalState(
            user: getCurrentUserUseCase.execute(NoParams()),
            groupsCount: getGroupsCountUseCase.execute(NoParams()),
            currentGroup: getCurrentGroupUseCase.execute(NoParams()),
          ),
        ) {
    on<UserChanged>(_onUserChanged);
    on<CurrentGroupChanged>(_onCurrentGroupChanged);
    on<GroupsCountChanged>(_onGroupsCountChanged);

    on<ChangeGroup>(_onChangeGroup);
    on<GoToMyInvitations>(_onGoToMyInvitations);
    on<GoToMyGroups>(_onGoToMyGroups);

    on<CompletedTackTackIntentAction>(_onCompletedTackTackIntentAction);
    on<CancelTackerTackRunnerIntentAction>(
      _onCancelTackerTackRunnerIntentAction,
    );

    _userSubscription =
        _observeUserUseCase.execute(NoParams()).listen((User event) {
      add(UserChanged(user: event));
    });
    _currentGroupSubscription =
        _observeCurrentGroupUseCase.execute(NoParams()).listen((Group? event) {
      add(CurrentGroupChanged(group: event));
    });
    _groupsCountSubscription =
        _observeGroupsCountUseCase.execute(NoParams()).listen((int event) {
      add(GroupsCountChanged(groupsCount: event));
    });

    _completedRackRunnerIntentSubscription =
        _observeCompletedTackRunnerIntentUseCase
            .execute(NoParams())
            .listen((WebSocketIntent<Tack> tackIntent) {
      add(CompletedTackTackIntentAction(tackIntent: tackIntent));
    });
    _cancelTackerTackRunnerIntentSubscription =
        _observeCancelTackerTackRunnerIntentUseCase
            .execute(NoParams())
            .listen((WebSocketIntent<Tack> tackIntent) {
      add(CancelTackerTackRunnerIntentAction(tackIntent: tackIntent));
    });
  }

  Future<void> _onUserChanged(
    UserChanged event,
    Emitter<GlobalState> emit,
  ) async {
    emit(
      state.copyWith(user: event.user),
    );

    if (event.user.activeGroup == state.currentGroup?.id) return;
    if (event.user.activeGroup == null) return;

    try {
      final GroupDetails groupDetails = await _fetchGroupUseCase.execute(
        FetchGroupPayload(id: event.user.activeGroup!),
      );
      await _selectGroupUseCase.execute(
        SelectGroupPayload(group: groupDetails.group),
      );
    } catch (_) {}
  }

  Future<void> _onCurrentGroupChanged(
    CurrentGroupChanged event,
    Emitter<GlobalState> emit,
  ) async {
    emit(
      state.copyWith(
        currentGroup: Optional(event.group),
      ),
    );
  }

  Future<void> _onGroupsCountChanged(
    GroupsCountChanged event,
    Emitter<GlobalState> emit,
  ) async {
    emit(state.copyWith(groupsCount: event.groupsCount));
  }

  Future<void> _onChangeGroup(
    ChangeGroup event,
    Emitter<GlobalState> emit,
  ) async {
    final Group? newGroup = await _appRouter.pushForResult(
      PickGroupDrawerFeature.page(state.currentGroup),
    );

    if (newGroup != null) {
      _selectGroupUseCase.execute(
        SelectGroupPayload(group: newGroup),
      );
    }
  }

  Future<void> _onGoToMyInvitations(
    GoToMyInvitations event,
    Emitter<GlobalState> emit,
  ) async {
    _appRouter.push(InvitationsFeature.page());
  }

  Future<void> _onGoToMyGroups(
    GoToMyGroups event,
    Emitter<GlobalState> emit,
  ) async {
    _appRouter.push(MyGroupsFeature.page());
  }

  Future<void> _onCompletedTackTackIntentAction(
    CompletedTackTackIntentAction event,
    Emitter<GlobalState> emit,
  ) async {
    if (event.tackIntent.action.isCreate) {
      final Tack tack = event.tackIntent.object!;

      _appRouter.pushForResult(
        AppAlertDialog.page(
          SuccessAlert(
            contentKey: 'otherAlert.runnerTackCompleted',
            translationParams: <AlertPropertyKey, Map<String, String>>{
              AlertPropertyKey.message: <String, String>{
                'tackPrice': tack.price.toStringAsFixed(2),
                'tackName': tack.title,
              },
            },
          ),
        ),
      );
    }
  }

  Future<void> _onCancelTackerTackRunnerIntentAction(
    CancelTackerTackRunnerIntentAction event,
    Emitter<GlobalState> emit,
  ) async {
    if (event.tackIntent.action.isCreate) {
      final Tack tack = event.tackIntent.object!;

      _appRouter.pushForResult(
        AppAlertDialog.page(
          ErrorAlert(
            contentKey: 'errorAlert.tackerTackRunnerCancel',
            translationParams: <AlertPropertyKey, Map<String, String>>{
              AlertPropertyKey.message: <String, String>{
                'tackName': tack.title,
              },
            },
          ),
        ),
      );
    }
  }

  @override
  Future<void> close() async {
    _userSubscription.cancel();
    _currentGroupSubscription.cancel();
    _groupsCountSubscription.cancel();

    _completedRackRunnerIntentSubscription.cancel();
    _cancelTackerTackRunnerIntentSubscription.cancel();

    return super.close();
  }
}
