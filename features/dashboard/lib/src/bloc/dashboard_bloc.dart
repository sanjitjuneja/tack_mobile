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

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  final AppRouterDelegate _appRouter;
  final FetchGroupTacksUseCase _fetchGroupTacksUseCase;
  final MakeOfferUseCase _makeOfferUseCase;

  DashboardBloc({
    required AppRouterDelegate appRouter,
    required FetchGroupTacksUseCase fetchGroupTacksUseCase,
    required MakeOfferUseCase makeOfferUseCase,
    required Group selectedGroup,
  })  : _appRouter = appRouter,
        _fetchGroupTacksUseCase = fetchGroupTacksUseCase,
        _makeOfferUseCase = makeOfferUseCase,
        super(
          DashboardState(
            group: selectedGroup,
            isLoading: true,
          ),
        ) {
    on<GoToCreateTack>(_onGoToCreateTack);

    on<InitialLoad>(_onInitialLoad);
    on<RefreshAction>(_onRefreshAction);
    on<LoadMoreAction>(_onLoadMoreAction);

    on<OpenOwnOngoingTack>(_onOpenOwnOngoingTack);
    on<CounterOfferOpen>(_onCounterOfferOpen);
    on<AcceptTack>(_onAcceptTack);

    add(const InitialLoad());
  }

  Future<void> _onGoToCreateTack(
    GoToCreateTack event,
    Emitter<DashboardState> emit,
  ) async {
    _appRouter.navigationTabState.changeTabIndex(HomeScreenTab.add);
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

  Future<void> _onOpenOwnOngoingTack(
    OpenOwnOngoingTack event,
    Emitter<DashboardState> emit,
  ) async {
    _appRouter.pushForResult(
      OngoingTackerTack.page(
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
      _appRouter.push(ProgressDialog.page());
      await _makeOfferUseCase.execute(
        MakeOfferPayload(
          tackId: event.groupTack.tack.id,
        ),
      );
      _appRouter.pop();
      result = true;
    } catch (e) {
      _appRouter.pop();
      error = e.toString();
    }

    _onTackRequestAnswer(result, error);
  }

  Future<void> _onTackRequestAnswer(
    bool result,
    String? error,
  ) async {
    if (result) {
      final bool dialogResult = await _appRouter.pushForResult(
        AppAlertDialog.page(
          RequestAlert(
            contentKey: 'otherAlert.offerSent',
          ),
        ),
      );
      if (dialogResult) {
        _appRouter.navigationTabState.changeTabIndex(HomeScreenTab.tacks);
      }
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
}
