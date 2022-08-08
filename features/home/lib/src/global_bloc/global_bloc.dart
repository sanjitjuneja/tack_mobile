import 'dart:async';

import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:domain/domain.dart';
import 'package:domain/use_case.dart';
import 'package:home/home.dart';
import 'package:navigation/navigation.dart';

part 'global_event.dart';

part 'global_state.dart';

class GlobalBloc extends Bloc<GlobalEvent, GlobalState> {
  final AppRouterDelegate _appRouter;
  final ObserveUserUseCase _observeUserUseCase;
  final ObserveCurrentGroupUseCase _observeCurrentGroupUseCase;
  final ObserveGroupsUseCase _observeGroupsUseCase;
  final SelectGroupUseCase _selectGroupUseCase;

  late StreamSubscription<User> _userSubscription;
  late StreamSubscription<Group?> _currentGroupSubscription;
  late StreamSubscription<List<Group>> _groupsSubscription;

  GlobalBloc({
    required AppRouterDelegate appRouter,
    required GetCurrentUserUseCase getCurrentUserUseCase,
    required ObserveUserUseCase observeUserUseCase,
    required GetCurrentGroupUseCase getCurrentGroupUseCase,
    required GetGroupsUseCase getGroupsUseCase,
    required ObserveCurrentGroupUseCase observeCurrentGroupUseCase,
    required ObserveGroupsUseCase observeGroupsUseCase,
    required SelectGroupUseCase selectGroupUseCase,
  })  : _appRouter = appRouter,
        _observeUserUseCase = observeUserUseCase,
        _observeCurrentGroupUseCase = observeCurrentGroupUseCase,
        _observeGroupsUseCase = observeGroupsUseCase,
        _selectGroupUseCase = selectGroupUseCase,
        super(
          GlobalState(
            user: getCurrentUserUseCase.execute(NoParams()),
            groups: getGroupsUseCase.execute(NoParams()),
            currentGroup: getCurrentGroupUseCase.execute(NoParams()),
          ),
        ) {
    on<UserChanged>(_onUserChanged);
    on<CurrentGroupChanged>(_onCurrentGroupChanged);
    on<GroupsChanged>(_onGroupsChanged);

    on<ChangeGroup>(_onChangeGroup);
    on<GoToMyInvitations>(_onGoToMyInvitations);

    _userSubscription =
        _observeUserUseCase.execute(NoParams()).listen((User event) {
      add(UserChanged(user: event));
    });
    _currentGroupSubscription =
        _observeCurrentGroupUseCase.execute(NoParams()).listen((Group? event) {
      add(CurrentGroupChanged(group: event));
    });
    _groupsSubscription =
        _observeGroupsUseCase.execute(NoParams()).listen((List<Group> event) {
      add(GroupsChanged(groups: event));
    });
  }

  Future<void> _onUserChanged(
    UserChanged event,
    Emitter<GlobalState> emit,
  ) async {
    emit(state.copyWith(user: event.user));
  }

  Future<void> _onCurrentGroupChanged(
    CurrentGroupChanged event,
    Emitter<GlobalState> emit,
  ) async {
    emit(state.copyWith(currentGroup: event.group));
  }

  Future<void> _onGroupsChanged(
    GroupsChanged event,
    Emitter<GlobalState> emit,
  ) async {
    emit(state.copyWith(groups: event.groups));
  }

  Future<void> _onChangeGroup(
    ChangeGroup event,
    Emitter<GlobalState> emit,
  ) async {
    if (state.groups.length < 2) return;

    HapticFeedbackManager.heavyImpact();
    final Group? newGroup = await _appRouter.pushForResult(
      ChangeGroupDrawer.page(
        state.groups,
        state.currentGroup,
      ),
    );

    if (newGroup != null) {
      _selectGroupUseCase.execute(SelectGroupPayload(group: newGroup));
    }
  }

  Future<void> _onGoToMyInvitations(
    GoToMyInvitations event,
    Emitter<GlobalState> emit,
  ) async {}

  @override
  Future<void> close() async {
    _userSubscription.cancel();
    _currentGroupSubscription.cancel();
    _groupsSubscription.cancel();

    return super.close();
  }
}
