import 'dart:async';

import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:domain/domain.dart';
import 'package:home/home.dart';
import 'package:navigation/navigation.dart';
import 'package:tacks/tacks.dart';

import '../counter_offer_screen/ui/counter_offer_page.dart';

part 'dashboard_event.dart';

part 'dashboard_state.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState>
    with AppLifeCycleObserver {
  final AppRouterDelegate _appRouter;
  final AppLifeCycleProvider _appLifeCycleProvider;
  final FetchGroupTacksUseCase _fetchGroupTacksUseCase;
  final ObserveGroupTackIntentUseCase _observeGroupTackIntentUseCase;
  final MakeOfferUseCase _makeOfferUseCase;

  late StreamSubscription<WebSocketIntent<GroupTack>>
      _groupTackIntentSubscription;

  DashboardBloc({
    required AppRouterDelegate appRouter,
    required AppLifeCycleProvider appLifeCycleProvider,
    required FetchGroupTacksUseCase fetchGroupTacksUseCase,
    required ObserveGroupTackIntentUseCase observeGroupTackIntentUseCase,
    required MakeOfferUseCase makeOfferUseCase,
    required Group selectedGroup,
  })  : _appRouter = appRouter,
        _appLifeCycleProvider = appLifeCycleProvider,
        _fetchGroupTacksUseCase = fetchGroupTacksUseCase,
        _observeGroupTackIntentUseCase = observeGroupTackIntentUseCase,
        _makeOfferUseCase = makeOfferUseCase,
        super(
          DashboardState(
            group: selectedGroup,
            isLoading: true,
          ),
        ) {
    _appLifeCycleProvider.addObserver(this);

    on<GoToCreateTack>(_onGoToCreateTack);

    on<AppRefreshAction>(_onAppRefreshAction);
    on<InitialLoad>(_onInitialLoad);
    on<RefreshAction>(_onRefreshAction);
    on<LoadMoreAction>(_onLoadMoreAction);

    on<GroupTackIntentAction>(_onGroupTackIntentAction);

    on<OpenOwnRunningOngoingTack>(_onOpenOwnRunningOngoingTack);
    on<OpenOwnCreatedOngoingTack>(_onOpenOwnOngoingTack);
    on<CounterOfferOpen>(_onCounterOfferOpen);
    on<AcceptTack>(_onAcceptTack);

    _groupTackIntentSubscription = _observeGroupTackIntentUseCase
        .execute(NoParams())
        .listen((WebSocketIntent<GroupTack> groupTackIntent) {
      add(GroupTackIntentAction(groupTackIntent: groupTackIntent));
    });

    add(const InitialLoad());
  }

  Future<void> _onGoToCreateTack(
    GoToCreateTack event,
    Emitter<DashboardState> emit,
  ) async {
    _appRouter.navigationTabState.changeTabIndex(HomeScreenTab.add);
  }

  Future<void> _onAppRefreshAction(
    AppRefreshAction event,
    Emitter<DashboardState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));
    add(const RefreshAction());
  }

  Future<void> _onInitialLoad(
    InitialLoad event,
    Emitter<DashboardState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));
    add(const RefreshAction());
  }

  Future<void> _onRefreshAction(
    RefreshAction event,
    Emitter<DashboardState> emit,
  ) async {
    try {
      final PaginationModel<GroupTack> tacksData =
          await _fetchGroupTacksUseCase.execute(
        FetchGroupTacksPayload(groupId: state.group.id),
      );

      event.completer?.complete(RefreshingStatus.complete);
      emit(
        state.copyWith(
          tacksData: tacksData,
        ),
      );
    } catch (_) {
      event.completer?.complete(RefreshingStatus.failed);
      if (event.completer == null) {
        emit(
          state.copyWith(
            tacksData: PaginationModel.empty(),
          ),
        );
      }
    }
  }

  Future<void> _onLoadMoreAction(
    LoadMoreAction event,
    Emitter<DashboardState> emit,
  ) async {
    try {
      final PaginationModel<GroupTack> tacksData =
          await _fetchGroupTacksUseCase.execute(
        FetchGroupTacksPayload(
          groupId: state.group.id,
          lastObjectId: state.tacksData.results.lastOrNull?.id,
          nextPage: state.tacksData.next,
        ),
      );

      event.completer.complete(LoadingStatus.complete);
      emit(
        state.copyWith(
          tacksData: state.tacksData.more(
            newPage: tacksData,
          ),
        ),
      );
    } catch (_) {
      event.completer.complete(LoadingStatus.failed);
    }
  }

  Future<void> _onGroupTackIntentAction(
    GroupTackIntentAction event,
    Emitter<DashboardState> emit,
  ) async {
    final WebSocketIntent<GroupTack> intent = event.groupTackIntent;

    final bool hasGroupId = !intent.action.isDelete;
    final bool isSameGroup = intent.object?.tack.group.id == state.group.id;

    if (hasGroupId && !isSameGroup) return;

    final PaginationModel<GroupTack> tacksData;
    switch (intent.action) {
      case WebSocketAction.create:
        tacksData = state.tacksData.addItem(
          item: intent.object!,
        );
        break;
      case WebSocketAction.update:
        tacksData = state.tacksData.updateItem(
          item: intent.object!,
        );
        break;
      case WebSocketAction.delete:
        tacksData = state.tacksData.removeItem(
          itemId: intent.objectId,
        );
        break;
    }

    emit(
      state.copyWith(tacksData: tacksData),
    );
  }

  Future<void> _onOpenOwnRunningOngoingTack(
    OpenOwnRunningOngoingTack event,
    Emitter<DashboardState> emit,
  ) async {
    _appRouter.navigationTabState.changeInnerTabIndex(HomeScreenTab.tacks, 1);
    _appRouter.navigationTabState.changeTabIndex(HomeScreenTab.tacks);
  }

  Future<void> _onOpenOwnOngoingTack(
    OpenOwnCreatedOngoingTack event,
    Emitter<DashboardState> emit,
  ) async {
    _appRouter.push(
      OngoingTackerTackFeature.page(
        tack: event.groupTack.tack,
      ),
    );
  }

  Future<void> _onCounterOfferOpen(
    CounterOfferOpen event,
    Emitter<DashboardState> emit,
  ) async {
    final bool? result = await _appRouter.pushForResult(
      CounterOffer.page(groupTack: event.groupTack),
    );

    if (result != null) {
      _onTackRequestAnswer(result, 'not available');
    }
  }

  Future<void> _onAcceptTack(
    AcceptTack event,
    Emitter<DashboardState> emit,
  ) async {
    bool result = false;
    String? error;

    try {
      _appRouter.pushProgress();
      await _makeOfferUseCase.execute(
        MakeOfferPayload(
          tackId: event.groupTack.tack.id,
        ),
      );
      _appRouter.popProgress();
      result = true;
    } catch (e) {
      _appRouter.popProgress();
      error = e.toString();
    }

    _onTackRequestAnswer(result, error);
  }

  Future<void> _onTackRequestAnswer(
    bool result,
    String? error,
  ) async {
    if (result) {
      _appRouter.pushForResult(
        AppAlertDialog.page(
          RequestAlert(
            contentKey: 'otherAlert.offerSent',
          ),
        ),
      );
    } else if (error.toString().toLowerCase().contains('not available')) {
      _appRouter.pushForResult(
        AppAlertDialog.page(
          ErrorAlert(
            contentKey: 'errorAlert.offerSending',
            messageKey: 'errors.tackIsNotAvailable',
          ),
        ),
      );
    } else {
      _appRouter.pushForResult(
        AppAlertDialog.page(
          ErrorAlert(
            contentKey: 'errorAlert.offerSending',
            messageKey: error.toString(),
          ),
        ),
      );
    }
  }

  @override
  void onShouldRefresh() {
    add(const AppRefreshAction());
  }

  @override
  Future<void> close() async {
    _groupTackIntentSubscription.cancel();
    _appLifeCycleProvider.removeObserver(this);

    return super.close();
  }
}
