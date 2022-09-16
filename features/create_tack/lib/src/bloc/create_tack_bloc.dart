import 'dart:async';

import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import '../models/group_tacks_state.dart';
import '../models/nearby_tacks_state.dart';
import 'package:domain/domain.dart';
import 'package:home/home.dart';
import 'package:navigation/navigation.dart';
import 'package:tacks/tacks.dart';

part 'create_tack_event.dart';

part 'create_tack_state.dart';

class CreateTackBloc extends Bloc<CreateTackEvent, CreateTackState> {
  final AppRouterDelegate _appRouter;
  final FetchNearbyPopularTacksUseCase _fetchNearbyPopularTacksUseCase;
  final FetchGroupPopularTacksUseCase _fetchGroupPopularTacksUseCase;

  late StreamSubscription<GlobalState> _globalBlocSubscription;

  CreateTackBloc({
    required GlobalBloc globalBloc,
    required AppRouterDelegate appRouter,
    required FetchNearbyPopularTacksUseCase fetchNearbyPopularTacksUseCase,
    required FetchGroupPopularTacksUseCase fetchGroupPopularTacksUseCase,
  })  : _appRouter = appRouter,
        _fetchNearbyPopularTacksUseCase = fetchNearbyPopularTacksUseCase,
        _fetchGroupPopularTacksUseCase = fetchGroupPopularTacksUseCase,
        super(
          CreateTackState(
            group: globalBloc.state.currentGroup,
            nearbyTacksState: const NearbyTacksState(isLoading: true),
            groupTacksState: const GroupTacksState(isLoading: true),
          ),
        ) {
    on<InitialLoad>(_onInitialLoad);
    on<GroupChanged>(_onGroupChanged);

    on<RefreshNearbyTacks>(_onRefreshNearbyTacks);
    on<RefreshGroupTacks>(_onRefreshGroupTacks);

    on<CreateTackAction>(_onCreateTackAction);

    _globalBlocSubscription = globalBloc.stream.listen((GlobalState state) {
      add(GroupChanged(group: state.currentGroup));
    });

    add(const InitialLoad());
  }

  Future<void> _onInitialLoad(
    InitialLoad event,
    Emitter<CreateTackState> emit,
  ) async {
    add(const RefreshNearbyTacks());
    add(const RefreshGroupTacks());
  }

  Future<void> _onGroupChanged(
    GroupChanged event,
    Emitter<CreateTackState> emit,
  ) async {
    emit(
      state.copyWith(
        group: event.group,
        groupTacksState: state.groupTacksState.copyWith(isLoading: true),
      ),
    );
    add(const RefreshGroupTacks());
  }

  Future<void> _onRefreshNearbyTacks(
    RefreshNearbyTacks event,
    Emitter<CreateTackState> emit,
  ) async {
    try {
      final List<TemplateTack> tacks =
          await _fetchNearbyPopularTacksUseCase.execute(
        const FetchNearbyPopularTacksPayload(),
      );
      event.completer?.complete(RefreshingStatus.complete);
      emit(
        state.copyWith(
          nearbyTacksState: state.nearbyTacksState.copyWith(
            tacks: tacks,
          ),
        ),
      );
    } catch (e) {
      event.completer?.complete(RefreshingStatus.failed);
      if (event.completer == null) {
        emit(
          state.copyWith(
            nearbyTacksState: const NearbyTacksState(),
          ),
        );
      }
    }
  }

  Future<void> _onRefreshGroupTacks(
    RefreshGroupTacks event,
    Emitter<CreateTackState> emit,
  ) async {
    if (state.group == null) {
      event.completer?.complete(RefreshingStatus.complete);
      emit(
        state.copyWith(
          groupTacksState: const GroupTacksState(),
        ),
      );

      return;
    }

    try {
      final List<TemplateTack> tacks =
          await _fetchGroupPopularTacksUseCase.execute(
        FetchGroupPopularTacksPayload(
          groupId: state.group!.id,
        ),
      );
      event.completer?.complete(RefreshingStatus.complete);
      emit(
        state.copyWith(
          groupTacksState: state.groupTacksState.copyWith(
            tacks: tacks,
          ),
        ),
      );
    } catch (e) {
      event.completer?.complete(RefreshingStatus.failed);
      if (event.completer == null) {
        emit(
          state.copyWith(
            groupTacksState: const GroupTacksState(),
          ),
        );
      }
    }
  }

  Future<void> _onCreateTackAction(
    CreateTackAction event,
    Emitter<CreateTackState> emit,
  ) async {
    final Tack? newTack = await _appRouter.pushForResult(
      AddEditTackFeature.addPage(
        templateTack: event.tack,
      ),
    );

    if (newTack == null) return;

    _appRouter.push(
      OngoingTackerTackFeature.page(
        tack: newTack,
      ),
    );

    _appRouter.navigationTabState.changeInnerTabIndex(HomeScreenTab.tacks, 0);
    _appRouter.navigationTabState.changeTabIndex(HomeScreenTab.tacks);
  }

  @override
  Future<void> close() {
    _globalBlocSubscription.cancel();

    return super.close();
  }
}
