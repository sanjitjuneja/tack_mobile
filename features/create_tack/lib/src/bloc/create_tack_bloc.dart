import 'dart:async';

import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:create_tack/src/models/group_tacks_state.dart';
import 'package:create_tack/src/models/nearby_tacks_state.dart';
import 'package:domain/domain.dart';
import 'package:home/home.dart';
import 'package:navigation/navigation.dart';
import 'package:tacks/tacks.dart';

part 'create_tack_event.dart';

part 'create_tack_state.dart';

class CreateTackBloc extends Bloc<CreateTackEvent, CreateTackState> {
  final AppRouterDelegate _appRouter;
  final GetNearbyPopularTacksUseCase _getNearbyPopularTacksUseCase;
  final GetGroupPopularTacksUseCase _getGroupPopularTacksUseCase;

  late StreamSubscription<GlobalState> _globalBlocSubscription;

  CreateTackBloc({
    required GlobalBloc globalBloc,
    required AppRouterDelegate appRouter,
    required GetNearbyPopularTacksUseCase getNearbyPopularTacksUseCase,
    required GetGroupPopularTacksUseCase getGroupPopularTacksUseCase,
  })  : _appRouter = appRouter,
        _getNearbyPopularTacksUseCase = getNearbyPopularTacksUseCase,
        _getGroupPopularTacksUseCase = getGroupPopularTacksUseCase,
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
      final List<TemplateTack> tacks = await _getNearbyPopularTacksUseCase
          .execute(const NearbyPopularTacksPayload());
      event.completer?.complete(RefreshingStatus.complete);
      emit(
        state.copyWith(
          nearbyTacksState: state.nearbyTacksState.copyWith(tacks: tacks),
        ),
      );
    } catch (e) {
      event.completer?.complete(RefreshingStatus.failed);
      if (event.completer == null) {
        emit(
          state.copyWith(nearbyTacksState: const NearbyTacksState()),
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
      final List<TemplateTack> tacks = await _getGroupPopularTacksUseCase
          .execute(GroupPopularTacksPayload(groupId: state.group!.id));
      event.completer?.complete(RefreshingStatus.complete);
      emit(
        state.copyWith(
          groupTacksState: state.groupTacksState.copyWith(tacks: tacks),
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
    _appRouter.pushForResult(AddEditTack.addPage(templateTack: event.tack));
  }

  @override
  Future<void> close() {
    _globalBlocSubscription.cancel();

    return super.close();
  }
}
