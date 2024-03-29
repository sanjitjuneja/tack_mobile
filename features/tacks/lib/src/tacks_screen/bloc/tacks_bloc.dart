import 'dart:async';

import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:domain/domain.dart';
import 'package:home/home.dart';
import 'package:navigation/navigation.dart';

import '../../ongoing_tack/ongoing_runner_tack/ui/ongoing_runner_tack_page.dart';
import '../../ongoing_tack/ongoing_tacker_tack/ui/ongoing_tacker_tack_page.dart';
import '../models/runner_tacks_data.dart';
import '../models/tacker_tacks_data.dart';

part 'tacks_event.dart';

part 'tacks_state.dart';

class TacksBloc extends Bloc<TacksEvent, TacksState> with AppLifeCycleObserver {
  final AppRouterDelegate _appRouter;
  final AppLifeCycleProvider _appLifeCycleProvider;
  final FetchRunnerTacksUseCase _fetchRunnerTacksUseCase;
  final FetchTackerTacksUseCase _fetchTackerTacksUseCase;
  final ObserveRunnerTackIntentUseCase _observeRunnerTackIntentUseCase;
  final ObserveTackerTackIntentUseCase _observeTackerTackIntentUseCase;
  final CancelOfferUseCase _cancelOfferUseCase;

  late StreamSubscription<WebSocketIntent<RunnerTack>>
      _runnerTackIntentSubscription;
  late StreamSubscription<WebSocketIntent<Tack>> _tackerTackIntentSubscription;

  TacksBloc({
    required AppRouterDelegate appRouter,
    required AppLifeCycleProvider appLifeCycleProvider,
    required FetchRunnerTacksUseCase fetchRunnerTacksUseCase,
    required FetchTackerTacksUseCase fetchTackerTacksUseCase,
    required ObserveRunnerTackIntentUseCase observeRunnerTackIntentUseCase,
    required ObserveTackerTackIntentUseCase observeTackerTackIntentUseCase,
    required CancelOfferUseCase cancelOfferUseCase,
  })  : _appRouter = appRouter,
        _appLifeCycleProvider = appLifeCycleProvider,
        _fetchRunnerTacksUseCase = fetchRunnerTacksUseCase,
        _fetchTackerTacksUseCase = fetchTackerTacksUseCase,
        _observeRunnerTackIntentUseCase = observeRunnerTackIntentUseCase,
        _observeTackerTackIntentUseCase = observeTackerTackIntentUseCase,
        _cancelOfferUseCase = cancelOfferUseCase,
        super(const TacksState()) {
    _appLifeCycleProvider.addObserver(this);

    on<MoveToAddTab>(_onMoveToAddTab);
    on<MoveToHomeTab>(_onMoveToHomeTab);

    on<InitialLoad>(_onInitialLoad);
    on<AppRefreshAction>(_onAppRefreshAction);
    on<RefreshRunnerTacks>(_onRefreshRunnerTacks);
    on<RefreshTackerTacks>(_onRefreshTackerTacks);

    on<RunnerTackIntentAction>(_onRunnerTackIntentAction);
    on<TackerTackIntentAction>(_onTackerTackIntentAction);

    on<RunnerTackOfferExpired>(_onRunnerTackOfferExpired);
    on<CancelTackOffer>(_onCancelTackOffer);
    on<OpenTackerTack>(_onOpenTackerTack);
    on<OpenRunnerTack>(_onOpenRunnerTack);

    _runnerTackIntentSubscription = _observeRunnerTackIntentUseCase
        .execute(NoParams())
        .listen((WebSocketIntent<RunnerTack> tackIntent) {
      add(RunnerTackIntentAction(tackIntent: tackIntent));
    });
    _tackerTackIntentSubscription = _observeTackerTackIntentUseCase
        .execute(NoParams())
        .listen((WebSocketIntent<Tack> tackIntent) {
      add(TackerTackIntentAction(tackIntent: tackIntent));
    });

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

  Future<void> _onRefreshRunnerTacks(
    RefreshRunnerTacks event,
    Emitter<TacksState> emit,
  ) async {
    try {
      final List<RunnerTack> tacks = await _fetchRunnerTacksUseCase.execute(
        const FetchRunnerTacksPayload(),
      );

      event.completer?.complete(RefreshingStatus.complete);
      emit(
        state.copyWith(
          runnerTacksData: state.runnerTacksData.copyWith(results: tacks),
        ),
      );
    } catch (_) {
      event.completer?.complete(RefreshingStatus.failed);
      if (event.completer == null) {
        emit(
          state.copyWith(
            runnerTacksData: const RunnerTacksState(),
          ),
        );
      }
    }
  }

  Future<void> _onAppRefreshAction(
    AppRefreshAction event,
    Emitter<TacksState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));
    add(const RefreshTackerTacks());
    add(const RefreshRunnerTacks());
  }

  Future<void> _onRefreshTackerTacks(
    RefreshTackerTacks event,
    Emitter<TacksState> emit,
  ) async {
    try {
      final List<Tack> tacks = await _fetchTackerTacksUseCase.execute(
        const FetchTackerTacksPayload(),
      );

      event.completer?.complete(RefreshingStatus.complete);
      emit(
        state.copyWith(
          tackerTacksData: state.tackerTacksData.copyWith(results: tacks),
        ),
      );
    } catch (_) {
      event.completer?.complete(RefreshingStatus.failed);
      if (event.completer == null) {
        emit(
          state.copyWith(
            tackerTacksData: const TackerTacksState(),
          ),
        );
      }
    }
  }

  Future<void> _onRunnerTackIntentAction(
    RunnerTackIntentAction event,
    Emitter<TacksState> emit,
  ) async {
    final WebSocketIntent<RunnerTack> intent = event.tackIntent;

    final RunnerTacksState runnerTacksData;

    switch (intent.action) {
      case WebSocketAction.create:
        runnerTacksData = state.runnerTacksData.addItem(
          item: intent.object!,
        );
        break;
      case WebSocketAction.update:
        runnerTacksData = state.runnerTacksData.updateItem(
          item: intent.object!,
        );
        break;
      case WebSocketAction.delete:
        runnerTacksData = state.runnerTacksData.removeItem(
          itemId: intent.objectId,
        );
        break;
    }

    emit(
      state.copyWith(runnerTacksData: runnerTacksData),
    );
  }

  Future<void> _onTackerTackIntentAction(
    TackerTackIntentAction event,
    Emitter<TacksState> emit,
  ) async {
    final WebSocketIntent<Tack> intent = event.tackIntent;

    final TackerTacksState tackerTacksData;

    switch (intent.action) {
      case WebSocketAction.create:
        tackerTacksData = state.tackerTacksData.addItem(
          item: intent.object!,
        );
        break;
      case WebSocketAction.update:
        tackerTacksData = state.tackerTacksData.updateItem(
          item: intent.object!,
        );
        break;
      case WebSocketAction.delete:
        tackerTacksData = state.tackerTacksData.removeItem(
          itemId: intent.objectId,
        );
        break;
    }

    emit(
      state.copyWith(tackerTacksData: tackerTacksData),
    );
  }

  Future<void> _onRunnerTackOfferExpired(
    RunnerTackOfferExpired event,
    Emitter<TacksState> emit,
  ) async {
    emit(
      state.copyWith(
        runnerTacksData: state.runnerTacksData.removeItem(
          itemId: event.runnerTack.id,
        ),
      ),
    );
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
      _appRouter.pushProgress();
      await _cancelOfferUseCase.execute(
        CancelOfferPayload(offer: event.runnerTack.offer!),
      );
      _appRouter.popProgress();
    } catch (e) {
      _appRouter.popProgress();
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
    _appRouter.push(
      OngoingTackerTackFeature.page(tack: event.tack),
    );
  }

  Future<void> _onOpenRunnerTack(
    OpenRunnerTack event,
    Emitter<TacksState> emit,
  ) async {
    _appRouter.push(
      OngoingRunnerTackFeature.page(runnerTack: event.runnerTack),
    );
  }

  @override
  void onShouldRefresh() {
    add(const AppRefreshAction());
  }

  @override
  Future<void> close() async {
    _runnerTackIntentSubscription.cancel();
    _tackerTackIntentSubscription.cancel();
    _appLifeCycleProvider.removeObserver(this);

    return super.close();
  }
}
