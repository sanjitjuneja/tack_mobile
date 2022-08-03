import 'dart:async';
import 'dart:math';

import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:dashboard/src/counter_offer_screen/ui/counter_offer_page.dart';
import 'package:domain/domain.dart';
import 'package:home/home.dart';
import 'package:navigation/navigation.dart';

part 'dashboard_event.dart';

part 'dashboard_state.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  final AppRouterDelegate _appRouter;
  final GetGroupTacksUseCase _getGroupTacksUseCase;

  DashboardBloc({
    required AppRouterDelegate appRouter,
    required GetGroupTacksUseCase getGroupTacksUseCase,
    required Group selectedGroup,
  })  : _appRouter = appRouter,
        _getGroupTacksUseCase = getGroupTacksUseCase,
        super(
          DashboardState(group: selectedGroup),
        ) {
    on<GoToCreateTack>(_onGoToCreateTack);

    on<InitialLoad>(_onInitialLoad);
    on<RefreshAction>(_onRefreshAction);
    on<LoadMoreAction>(_onLoadMoreAction);

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
    try {
      final List<Tack> tacks = await _getGroupTacksUseCase.execute(
        GroupTacksPayload(groupId: state.group.id),
      );

      emit(state.copyWith(tacks: tacks));
    } catch (e) {
      emit(state.copyWith(tacks: <Tack>[]));
    }
  }

  Future<void> _onRefreshAction(
    RefreshAction event,
    Emitter<DashboardState> emit,
  ) async {
    final List<Tack> tacks = await _getGroupTacksUseCase.execute(
      GroupTacksPayload(groupId: state.group.id),
    );

    event.completer.complete(RefreshingStatus.complete);
    emit(state.copyWith(tacks: tacks));
  }

  Future<void> _onLoadMoreAction(
    LoadMoreAction event,
    Emitter<DashboardState> emit,
  ) async {
    final List<Tack> tacks = await _getGroupTacksUseCase.execute(
      GroupTacksPayload(groupId: state.group.id),
    );

    event.completer.complete(LoadingStatus.complete);
    emit(state.copyWith(tacks: tacks));
  }

  Future<void> _onCounterOfferOpen(
    CounterOfferOpen event,
    Emitter<DashboardState> emit,
  ) async {
    final bool? result = await _appRouter.pushForResult(
      CounterOffer.page(tack: event.tack),
    );

    if (result != null) {
      _onTackRequestAnswer(result);
    }
  }

  Future<void> _onAcceptTack(
    AcceptTack event,
    Emitter<DashboardState> emit,
  ) async {
    _appRouter.push(ProgressDialog.page());
    // API request simulation.
    await Future.delayed(const Duration(seconds: 1));
    _appRouter.pop();

    const List<dynamic> answers = <dynamic>['some error', false, true];
    final dynamic answer = answers[Random().nextInt(answers.length)];
    if (answer is String) {
      _appRouter.pushForResult(
        AppAlertDialog.page(
          ErrorAlert(
            contentKey: 'errorAlert.offerSending',
          ),
        ),
      );
    } else {
      _onTackRequestAnswer(answer);
    }
  }

  Future<void> _onTackRequestAnswer(bool result) async {
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
    } else {
      _appRouter.pushForResult(
        AppAlertDialog.page(
          ErrorAlert(
            contentKey: 'errorAlert.offerSending',
            messageKey: 'errors.tackIsNotAvailable',
          ),
        ),
      );
    }
  }
}
