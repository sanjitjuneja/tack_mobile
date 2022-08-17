import 'dart:async';

import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:domain/domain.dart';
import 'package:domain/use_case.dart';
import 'package:home/home.dart';
import 'package:navigation/navigation.dart';
import 'package:tacks/src/ongoing_tack/ongoing_runner_tack/ui/ongoing_runner_tack_page.dart';

import 'package:tacks/src/tacks_screen/models/runner_tacks_data.dart';
import 'package:tacks/src/tacks_screen/models/tacker_tacks_data.dart';

import '../../ongoing_tack/ongoing_tacker_tack/ui/ongoing_tacker_tack_page.dart';

part 'tacks_event.dart';

part 'tacks_state.dart';

class TacksBloc extends Bloc<TacksEvent, TacksState> {
  final AppRouterDelegate _appRouter;
  final GetTackerTacksUseCase _getTackerTacksUseCase;
  final GetRunnerTacksUseCase _getRunnerTacksUseCase;
  final CancelOfferUseCase _cancelOfferUseCase;

  TacksBloc({
    required AppRouterDelegate appRouter,
    required GetTackerTacksUseCase getTackerTacksUseCase,
    required GetRunnerTacksUseCase getRunnerTacksUseCase,
    required CancelOfferUseCase cancelOfferUseCase,
  })  : _appRouter = appRouter,
        _getTackerTacksUseCase = getTackerTacksUseCase,
        _getRunnerTacksUseCase = getRunnerTacksUseCase,
        _cancelOfferUseCase = cancelOfferUseCase,
        super(
          const TacksState(
            tackerTacksState: TackerTacksState(isLoading: true),
            runnerTacksState: RunnerTacksState(isLoading: true),
          ),
        ) {
    on<MoveToAddTab>(_onMoveToAddTab);
    on<MoveToHomeTab>(_onMoveToHomeTab);

    on<InitialLoad>(_onInitialLoad);
    on<LoadRunnerTacks>(_onLoadRunnerTacks);
    on<RefreshRunnerTacks>(_onRefreshRunnerTacks);
    on<LoadTackerTacks>(_onLoadTackerTacks);
    on<RefreshTackerTacks>(_onRefreshTackerTacks);

    on<CancelTackOffer>(_onCancelTackOffer);
    on<OpenTackerTack>(_onOpenTackerTack);
    on<OpenRunnerTack>(_onOpenRunnerTack);

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
    add(const RefreshTackerTacks());
    add(const RefreshRunnerTacks());
  }

  Future<void> _onLoadRunnerTacks(
    LoadRunnerTacks event,
    Emitter<TacksState> emit,
  ) async {
    try {
      final List<RunnerTack> tacks =
          await _getRunnerTacksUseCase.execute(NoParams());

      event.completer.complete(LoadingStatus.complete);
      emit(
        state.copyWith(
          runnerTacksState: state.runnerTacksState.copyWith(tacks: tacks),
        ),
      );
    } catch (_) {
      event.completer.complete(LoadingStatus.failed);
    }
  }

  Future<void> _onRefreshRunnerTacks(
    RefreshRunnerTacks event,
    Emitter<TacksState> emit,
  ) async {
    try {
      final List<RunnerTack> tacks =
          await _getRunnerTacksUseCase.execute(NoParams());

      event.completer?.complete(RefreshingStatus.complete);
      emit(
        state.copyWith(
          runnerTacksState: state.runnerTacksState.copyWith(tacks: tacks),
        ),
      );
    } catch (_) {
      event.completer?.complete(RefreshingStatus.failed);
      if (event.completer == null) {
        emit(
          state.copyWith(runnerTacksState: const RunnerTacksState()),
        );
      }
    }
  }

  Future<void> _onLoadTackerTacks(
    LoadTackerTacks event,
    Emitter<TacksState> emit,
  ) async {
    try {
      final List<Tack> tacks = await _getTackerTacksUseCase.execute(NoParams());

      event.completer.complete(LoadingStatus.complete);
      emit(
        state.copyWith(
          tackerTacksState: state.tackerTacksState.copyWith(tacks: tacks),
        ),
      );
    } catch (_) {
      event.completer.complete(LoadingStatus.failed);
    }
  }

  Future<void> _onRefreshTackerTacks(
    RefreshTackerTacks event,
    Emitter<TacksState> emit,
  ) async {
    try {
      final List<Tack> tacks = await _getTackerTacksUseCase.execute(NoParams());

      event.completer?.complete(RefreshingStatus.complete);
      emit(
        state.copyWith(
          tackerTacksState: state.tackerTacksState.copyWith(tacks: tacks),
        ),
      );
    } catch (_) {
      event.completer?.complete(RefreshingStatus.failed);
      if (event.completer == null) {
        emit(
          state.copyWith(tackerTacksState: const TackerTacksState()),
        );
      }
    }
  }

  Future<void> _onCancelTackOffer(
    CancelTackOffer event,
    Emitter<TacksState> emit,
  ) async {
    final bool result = await _appRouter.pushForResult(
      DestructiveDialog.page(
        DestructiveAlert(
          contentKey: 'destructiveAlert.cancelOffer',
          translationParams: {
            AlertPropertyKey.message: {
              'tackName': event.runnerTack.tack.title,
            },
          },
        ),
      ),
    );
    if (!result) return;

    try {
      _appRouter.push(ProgressDialog.page());
      await _cancelOfferUseCase.execute(
        CancelOfferPayload(offer: event.runnerTack.offer!),
      );
      _appRouter.pop();
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

  Future<void> _onOpenTackerTack(
    OpenTackerTack event,
    Emitter<TacksState> emit,
  ) async {
    _appRouter.push(OngoingTackerTack.page(tack: event.tack));
  }

  Future<void> _onOpenRunnerTack(
    OpenRunnerTack event,
    Emitter<TacksState> emit,
  ) async {
    _appRouter.push(OngoingRunnerTack.page(tack: event.tack));
  }
}
