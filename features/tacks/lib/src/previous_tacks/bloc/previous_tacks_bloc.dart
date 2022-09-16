import 'dart:async';

import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:domain/domain.dart';
import 'package:domain/use_case.dart';
import 'package:home/home.dart';
import 'package:navigation/navigation.dart';

import '../../tack_options_drawer/ui/tack_options_drawer_page.dart';

part 'previous_tacks_event.dart';

part 'previous_tacks_state.dart';

class PreviousTacksBloc extends Bloc<PreviousTacksEvent, PreviousTacksState> {
  final AppRouterDelegate _appRouter;
  final FetchCreatedTacksUseCase _fetchCreatedTacksUseCase;
  final FetchCompletedTacksUseCase _fetchCompletedTacksUseCase;
  final ObserveCompletedTackRunnerIntentUseCase
      _observeCompletedTackRunnerIntentUseCase;

  late StreamSubscription<WebSocketIntent<Tack>>
      _completedTackRunnerIntentSubscription;

  PreviousTacksBloc({
    required AppRouterDelegate appRouter,
    required FetchCreatedTacksUseCase fetchCreatedTacksUseCase,
    required FetchCompletedTacksUseCase fetchCompletedTacksUseCase,
    required ObserveCompletedTackRunnerIntentUseCase
        observeCompletedTackRunnerIntentUseCase,
  })  : _appRouter = appRouter,
        _fetchCreatedTacksUseCase = fetchCreatedTacksUseCase,
        _fetchCompletedTacksUseCase = fetchCompletedTacksUseCase,
        _observeCompletedTackRunnerIntentUseCase =
            observeCompletedTackRunnerIntentUseCase,
        super(
          PreviousTacksState(
            isLoading: true,
          ),
        ) {
    on<InitialLoad>(_onInitialLoad);
    on<RefreshCreatedTacks>(_onRefreshCreatedTacks);
    on<LoadCreatedTacks>(_onLoadCreatedTacks);
    on<RefreshCompletedTacks>(_onRefreshCompletedTacks);
    on<LoadCompletedTacks>(_onLoadCompletedTacks);

    on<CompletedTackTackIntentAction>(_onCompletedTackTackIntentAction);

    on<OpenOptions>(_onOpenOptions);

    on<MoveToCreateTackTab>(_onMoveToCreateTackTab);
    on<MoveToHomeTab>(_onMoveToHomeTab);

    _completedTackRunnerIntentSubscription =
        _observeCompletedTackRunnerIntentUseCase
            .execute(NoParams())
            .listen((WebSocketIntent<Tack> tackIntent) {
      add(CompletedTackTackIntentAction(tackIntent: tackIntent));
    });

    add(const InitialLoad());
  }

  Future<void> _onInitialLoad(
    InitialLoad event,
    Emitter<PreviousTacksState> emit,
  ) async {
    add(const RefreshCreatedTacks());
    add(const RefreshCompletedTacks());
  }

  Future<void> _onRefreshCreatedTacks(
    RefreshCreatedTacks event,
    Emitter<PreviousTacksState> emit,
  ) async {
    try {
      final PaginationModel<Tack> tacksData =
          await _fetchCreatedTacksUseCase.execute(
        const FetchCreatedTacksPayload(),
      );

      event.completer?.complete(RefreshingStatus.complete);
      emit(
        state.copyWith(
          createdTacksData: tacksData,
        ),
      );
    } catch (_) {
      event.completer?.complete(RefreshingStatus.failed);
      if (event.completer == null) {
        emit(
          state.copyWith(
            createdTacksData: PaginationModel.empty(),
          ),
        );
      }
    }
  }

  Future<void> _onLoadCreatedTacks(
    LoadCreatedTacks event,
    Emitter<PreviousTacksState> emit,
  ) async {
    try {
      final PaginationModel<Tack> tacksData =
          await _fetchCreatedTacksUseCase.execute(
        FetchCreatedTacksPayload(
          lastObjectId: state.createdTacksData.results.lastOrNull?.id,
          nextPage: state.createdTacksData.next,
        ),
      );

      event.completer.complete(LoadingStatus.complete);
      emit(
        state.copyWith(
          createdTacksData: state.createdTacksData.more(
            newPage: tacksData,
          ),
        ),
      );
    } catch (_) {
      event.completer.complete(LoadingStatus.failed);
    }
  }

  Future<void> _onRefreshCompletedTacks(
    RefreshCompletedTacks event,
    Emitter<PreviousTacksState> emit,
  ) async {
    try {
      final PaginationModel<Tack> tacksData =
          await _fetchCompletedTacksUseCase.execute(
        const FetchCompletedTacksPayload(),
      );

      event.completer?.complete(RefreshingStatus.complete);
      emit(
        state.copyWith(
          completedTacksData: tacksData,
        ),
      );
    } catch (_) {
      event.completer?.complete(RefreshingStatus.failed);
      if (event.completer == null) {
        emit(
          state.copyWith(
            completedTacksData: PaginationModel.empty(),
          ),
        );
      }
    }
  }

  Future<void> _onLoadCompletedTacks(
    LoadCompletedTacks event,
    Emitter<PreviousTacksState> emit,
  ) async {
    try {
      final PaginationModel<Tack> tacksData =
          await _fetchCompletedTacksUseCase.execute(
        FetchCompletedTacksPayload(
          lastObjectId: state.completedTacksData.results.lastOrNull?.id,
          nextPage: state.completedTacksData.next,
        ),
      );

      event.completer.complete(LoadingStatus.complete);
      emit(
        state.copyWith(
          completedTacksData: state.completedTacksData.more(
            newPage: tacksData,
          ),
        ),
      );
    } catch (_) {
      event.completer.complete(LoadingStatus.failed);
    }
  }

  Future<void> _onOpenOptions(
    OpenOptions event,
    Emitter<PreviousTacksState> emit,
  ) async {
    _appRouter.push(TackOptionsDrawerFeature.page());
  }

  Future<void> _onMoveToCreateTackTab(
    MoveToCreateTackTab event,
    Emitter<PreviousTacksState> emit,
  ) async {
    _appRouter.navigationTabState.changeTabIndex(HomeScreenTab.add);
    _appRouter.removeNamed(AppDrawer.routeName);
    _appRouter.pop();
  }

  Future<void> _onMoveToHomeTab(
    MoveToHomeTab event,
    Emitter<PreviousTacksState> emit,
  ) async {
    _appRouter.navigationTabState.changeTabIndex(HomeScreenTab.dashboard);
    _appRouter.removeNamed(AppDrawer.routeName);
    _appRouter.pop();
  }

  Future<void> _onCompletedTackTackIntentAction(
    CompletedTackTackIntentAction event,
    Emitter<PreviousTacksState> emit,
  ) async {
    final WebSocketIntent<Tack> intent = event.tackIntent;

    final PaginationModel<Tack> completedTacksData;

    switch (intent.action) {
      case WebSocketAction.create:
        completedTacksData = state.completedTacksData.addItem(
          item: intent.object!,
        );
        break;
      case WebSocketAction.update:
        completedTacksData = state.completedTacksData.updateItem(
          item: intent.object!,
        );
        break;
      case WebSocketAction.delete:
        completedTacksData = state.completedTacksData.removeItem(
          itemId: intent.objectId,
        );
        break;
    }

    emit(
      state.copyWith(completedTacksData: completedTacksData),
    );
  }

  @override
  Future<void> close() async {
    _completedTackRunnerIntentSubscription.cancel();

    return super.close();
  }
}
