import 'dart:async';

import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:domain/domain.dart';
import 'package:domain/use_case.dart';
import 'package:home/home.dart';
import 'package:navigation/navigation.dart';
import 'package:tacks/src/mocked_data/runner_tacks_data.dart';
import 'package:tacks/src/mocked_data/tacker_tacks.dart';
import 'package:tacks/src/tacks_screen/models/runner_tacks_data.dart';
import 'package:tacks/src/tacks_screen/models/tacker_tacks_data.dart';

part 'tacks_event.dart';

part 'tacks_state.dart';

class TacksBloc extends Bloc<TacksEvent, TacksState> {
  final AppRouterDelegate _appRouter;
  final GetTackerTacksUseCase _getTackerTacksUseCase;
  final GetRunnerTacksUseCase _getRunnerTacksUseCase;

  TacksBloc({
    required AppRouterDelegate appRouter,
    required GetTackerTacksUseCase getTackerTacksUseCase,
    required GetRunnerTacksUseCase getRunnerTacksUseCase,
  })  : _appRouter = appRouter,
        _getTackerTacksUseCase = getTackerTacksUseCase,
        _getRunnerTacksUseCase = getRunnerTacksUseCase,
        super(const TacksState()) {
    on<MoveToAddTab>(_onMoveToAddTab);
    on<MoveToHomeTab>(_onMoveToHomeTab);

    on<InitialLoad>(_onInitialLoad);
    on<LoadMockedData>(_onLoadMockedData);
    on<LoadRunnerTacks>(_onLoadRunnerTacks);
    on<RefreshRunnerTacks>(_onRefreshRunnerTacks);
    on<LoadTackerTacks>(_onLoadTackerTacks);
    on<RefreshTackerTacks>(_onRefreshTackerTacks);

    on<CancelTackOffer>(_onCancelTackOffer);

    add(const InitialLoad());
  }

  Future<void> _onMoveToAddTab(
    MoveToAddTab event,
    Emitter<TacksState> emit,
  ) async {
    _appRouter.navigationTabState.changeTabIndex(HomeScreenTab.add);
  }

  Future<void> _onMoveToHomeTab(
    MoveToHomeTab event,
    Emitter<TacksState> emit,
  ) async {
    _appRouter.navigationTabState.changeTabIndex(HomeScreenTab.dashboard);
  }

  Future<void> _onInitialLoad(
    InitialLoad event,
    Emitter<TacksState> emit,
  ) async {
    emit(
      state.copyWith(
        tackerTacksState: state.tackerTacksState.copyWith(isLoading: true),
        runnerTacksState: state.runnerTacksState.copyWith(isLoading: true),
      ),
    );
    try {
      final List<Tack> tacks = await _getTackerTacksUseCase.execute(NoParams());
      emit(
        state.copyWith(
          tackerTacksState: state.tackerTacksState.copyWith(tacks: tacks),
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(tackerTacksState: const TackerTacksState()),
      );
    }

    try {
      final List<RunnerTack> tacks =
          await _getRunnerTacksUseCase.execute(NoParams());
      emit(
        state.copyWith(
          runnerTacksState: state.runnerTacksState.copyWith(tacks: tacks),
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(runnerTacksState: const RunnerTacksState()),
      );
    }
  }

  Future<void> _onLoadMockedData(
    LoadMockedData event,
    Emitter<TacksState> emit,
  ) async {
    if (state.tackerTacksState.tacks.isNotEmpty) {
      emit(
        state.copyWith(
          tackerTacksState: const TackerTacksState(tacks: <Tack>[]),
          runnerTacksState: const RunnerTacksState(tacks: <RunnerTack>[]),
        ),
      );
    } else {
      emit(
        state.copyWith(
          tackerTacksState: TackerTacksState(tacks: tackerTacks),
          runnerTacksState: RunnerTacksState(tacks: runnerTacks),
        ),
      );
    }
  }

  Future<void> _onLoadRunnerTacks(
    LoadRunnerTacks event,
    Emitter<TacksState> emit,
  ) async {
    final List<RunnerTack> tacks =
    await _getRunnerTacksUseCase.execute(NoParams());
    event.completer.complete(LoadingStatus.complete);
    emit(
      state.copyWith(
        runnerTacksState: state.runnerTacksState.copyWith(tacks: tacks),
      ),
    );
  }

  Future<void> _onRefreshRunnerTacks(
    RefreshRunnerTacks event,
    Emitter<TacksState> emit,
  ) async {
    final List<RunnerTack> tacks =
    await _getRunnerTacksUseCase.execute(NoParams());
    event.completer.complete(RefreshingStatus.complete);
    emit(
      state.copyWith(
        runnerTacksState: state.runnerTacksState.copyWith(tacks: tacks),
      ),
    );
  }

  Future<void> _onLoadTackerTacks(
    LoadTackerTacks event,
    Emitter<TacksState> emit,
  ) async {
    final List<Tack> tacks = await _getTackerTacksUseCase.execute(NoParams());
    event.completer.complete(LoadingStatus.complete);
    emit(
      state.copyWith(
        tackerTacksState: state.tackerTacksState.copyWith(tacks: tacks),
      ),
    );
  }

  Future<void> _onRefreshTackerTacks(
    RefreshTackerTacks event,
    Emitter<TacksState> emit,
  ) async {
    final List<Tack> tacks = await _getTackerTacksUseCase.execute(NoParams());
    event.completer.complete(RefreshingStatus.complete);
    emit(
      state.copyWith(
        tackerTacksState: state.tackerTacksState.copyWith(tacks: tacks),
      ),
    );
  }

  Future<void> _onCancelTackOffer(
    CancelTackOffer event,
    Emitter<TacksState> emit,
  ) async {
    _appRouter.pushForResult(
      DestructiveDialog.page(
        DestructiveAlert(
          contentKey: 'destructiveAlert.cancelTackRunner',
          titleKey: '',
          translationParams: {
            AlertPropertyKey.message: {
              'tackName': event.tack.title,
            },
          },
        ),
      ),
    );
  }
}
