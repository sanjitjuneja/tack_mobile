import 'dart:async';

import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:domain/domain.dart';
import 'package:home/home.dart';
import 'package:navigation/navigation.dart';

import '../../ongoing_tack/ongoing_runner_tack/ui/ongoing_runner_tack_page.dart';
import '../../ongoing_tack/ongoing_tacker_tack/ui/ongoing_tacker_tack_page.dart';

part 'tacks_event.dart';

part 'tacks_state.dart';

class TacksBloc extends Bloc<TacksEvent, TacksState> {
  final AppRouterDelegate _appRouter;
  final FetchRunnerTacksUseCase _fetchRunnerTacksUseCase;
  final FetchTackerTacksUseCase _fetchTackerTacksUseCase;
  final CancelOfferUseCase _cancelOfferUseCase;

  TacksBloc({
    required AppRouterDelegate appRouter,
    required FetchRunnerTacksUseCase fetchRunnerTacksUseCase,
    required FetchTackerTacksUseCase fetchTackerTacksUseCase,
    required CancelOfferUseCase cancelOfferUseCase,
  })  : _appRouter = appRouter,
        _fetchRunnerTacksUseCase = fetchRunnerTacksUseCase,
        _fetchTackerTacksUseCase = fetchTackerTacksUseCase,
        _cancelOfferUseCase = cancelOfferUseCase,
        super(
          TacksState(
            isLoading: true,
          ),
        ) {
    on<MoveToAddTab>(_onMoveToAddTab);
    on<MoveToHomeTab>(_onMoveToHomeTab);

    on<InitialLoad>(_onInitialLoad);
    on<RefreshRunnerTacks>(_onRefreshRunnerTacks);
    on<LoadRunnerTacks>(_onLoadRunnerTacks);
    on<RefreshTackerTacks>(_onRefreshTackerTacks);
    on<LoadTackerTacks>(_onLoadTackerTacks);

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

  Future<void> _onRefreshRunnerTacks(
    RefreshRunnerTacks event,
    Emitter<TacksState> emit,
  ) async {
    try {
      final PaginationModel<RunnerTack> tacksData =
          await _fetchRunnerTacksUseCase.execute(
        const FetchRunnerTacksPayload(),
      );

      event.completer?.complete(RefreshingStatus.complete);
      emit(
        state.copyWith(
          runnerTacksData: tacksData,
        ),
      );
    } catch (_) {
      event.completer?.complete(RefreshingStatus.failed);
      if (event.completer == null) {
        emit(
          state.copyWith(
            runnerTacksData: PaginationModel.empty(),
          ),
        );
      }
    }
  }

  Future<void> _onLoadRunnerTacks(
    LoadRunnerTacks event,
    Emitter<TacksState> emit,
  ) async {
    try {
      final PaginationModel<RunnerTack> tacksData =
          await _fetchRunnerTacksUseCase.execute(
        FetchRunnerTacksPayload(
          lastObjectId: state.runnerTacksData.results.lastOrNull?.id,
          nextPage: state.runnerTacksData.next,
        ),
      );

      event.completer.complete(LoadingStatus.complete);
      emit(
        state.copyWith(
          runnerTacksData: state.runnerTacksData.more(
            newPage: tacksData,
          ),
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
      final PaginationModel<Tack> tacksData =
          await _fetchTackerTacksUseCase.execute(
        const FetchTackerTacksPayload(),
      );

      event.completer?.complete(RefreshingStatus.complete);
      emit(
        state.copyWith(
          tackerTacksData: tacksData,
        ),
      );
    } catch (_) {
      event.completer?.complete(RefreshingStatus.failed);
      if (event.completer == null) {
        emit(
          state.copyWith(
            tackerTacksData: PaginationModel.empty(),
          ),
        );
      }
    }
  }

  Future<void> _onLoadTackerTacks(
    LoadTackerTacks event,
    Emitter<TacksState> emit,
  ) async {
    try {
      final PaginationModel<Tack> tacksData =
          await _fetchTackerTacksUseCase.execute(
        FetchTackerTacksPayload(
          lastObjectId: state.tackerTacksData.results.lastOrNull?.id,
          nextPage: state.tackerTacksData.next,
        ),
      );

      event.completer.complete(LoadingStatus.complete);
      emit(
        state.copyWith(
          tackerTacksData: state.tackerTacksData.more(
            newPage: tacksData,
          ),
        ),
      );
    } catch (_) {
      event.completer.complete(LoadingStatus.failed);
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
    _appRouter.pushForResult(OngoingTackerTack.page(tack: event.tack));
  }

  Future<void> _onOpenRunnerTack(
    OpenRunnerTack event,
    Emitter<TacksState> emit,
  ) async {
    _appRouter.pushForResult(OngoingRunnerTack.page(tack: event.tack));
  }
}
