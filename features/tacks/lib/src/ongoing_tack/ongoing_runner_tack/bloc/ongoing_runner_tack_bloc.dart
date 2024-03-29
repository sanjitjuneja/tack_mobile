import 'dart:async';

import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:domain/domain.dart';
import 'package:navigation/navigation.dart';

import '../../models/running_tack_data.dart';
import '../../view_extensions/ongoing_tack_to_view_extension.dart';
import '../../../rate_tack_user/ui/rate_tack_user_page.dart';
import '../ui/ongoing_runner_tack_page.dart';

part 'ongoing_runner_tack_event.dart';

part 'ongoing_runner_tack_state.dart';

class OngoingRunnerTackBloc
    extends Bloc<OngoingRunnerTackEvent, OngoingRunnerTackState>
    with AppLifeCycleObserver {
  final AppRouterDelegate _appRouter;
  final AppLifeCycleProvider _appLifeCycleProvider;
  final ObserveRunnerTackIntentUseCase _observeRunnerTackIntentUseCase;
  final FetchTackUseCase _fetchTackUseCase;
  final FetchHasRunningTackUseCase _fetchHasRunningTackUseCase;
  final FetchUserContactsUseCase _fetchUserContactsUseCase;
  final CancelTackRunnerUseCase _cancelTackUseCase;
  final CompleteTackRunnerUseCase _completeTackUseCase;
  final StartTackRunnerUseCase _startTackUseCase;

  late StreamSubscription<WebSocketIntent<RunnerTack>> _tackIntentSubscription;

  OngoingRunnerTackBloc({
    required RunnerTack runnerTack,
    required AppLifeCycleProvider appLifeCycleProvider,
    required AppRouterDelegate appRouter,
    required ObserveRunnerTackIntentUseCase observeRunnerTackIntentUseCase,
    required FetchTackUseCase fetchTackUseCase,
    required FetchHasRunningTackUseCase fetchHasRunningTackUseCase,
    required FetchUserContactsUseCase fetchUserContactsUseCase,
    required CancelTackRunnerUseCase cancelTackRunnerUseCase,
    required CompleteTackRunnerUseCase completeTackUseCase,
    required StartTackRunnerUseCase startTackUseCase,
  })  : _appRouter = appRouter,
        _appLifeCycleProvider = appLifeCycleProvider,
        _observeRunnerTackIntentUseCase = observeRunnerTackIntentUseCase,
        _fetchTackUseCase = fetchTackUseCase,
        _fetchHasRunningTackUseCase = fetchHasRunningTackUseCase,
        _fetchUserContactsUseCase = fetchUserContactsUseCase,
        _cancelTackUseCase = cancelTackRunnerUseCase,
        _completeTackUseCase = completeTackUseCase,
        _startTackUseCase = startTackUseCase,
        super(
          OngoingRunnerTackState(
            runnerTack: runnerTack,
            stepsCount:
                OngoingTackToStepIndexViewExtension.runnerTackStepsCount,
            currentStep: runnerTack.tack.currentStepIndex(isTacker: false),
            runningTackData: const RunningTackData(
              isLoading: true,
            ),
          ),
        ) {
    appLifeCycleProvider.addObserver(this);

    on<RefreshAction>(_onRefreshAction);

    on<FetchHasRunningTackAction>(_onFetchHasRunningTackAction);
    on<FetchUserContactsAction>(_onFetchUserContactsAction);

    on<ActionPressed>(_onActionPressed);
    on<MessageTacker>(_onMessageTacker);
    on<CallTacker>(_onCallTacker);
    on<CancelTack>(_onCancelTack);

    on<TackIntentAction>(_onTackIntentAction);

    _tackIntentSubscription = _observeRunnerTackIntentUseCase
        .execute(NoParams())
        .listen((WebSocketIntent<RunnerTack> tackIntent) {
      add(TackIntentAction(tackIntent: tackIntent));
    });

    add(const FetchHasRunningTackAction());
    add(const FetchUserContactsAction());
  }

  Future<void> _onRefreshAction(
    RefreshAction event,
    Emitter<OngoingRunnerTackState> emit,
  ) async {
    try {
      emit(state.copyWith(isLoading: true));
      final Tack tack = await _fetchTackUseCase.execute(
        FetchTackPayload(
          id: state.runnerTack.tack.id,
        ),
      );
      if (tack.isCanceled || tack.status == TackStatus.completed) {
        _appRouter.removeNamed(
          OngoingRunnerTackFeature.routeName(
            id: state.runnerTack.id,
          ),
        );
      }
    } catch (e) {
      _appRouter.pushForResult(
        AppAlertDialog.page(
          ErrorAlert(
            messageKey: e.toString(),
          ),
        ),
      );
    } finally {
      emit(state.copyWith(isLoading: false));
    }
  }

  Future<void> _onFetchHasRunningTackAction(
    FetchHasRunningTackAction event,
    Emitter<OngoingRunnerTackState> emit,
  ) async {
    try {
      final bool hasRunningTack = await _fetchHasRunningTackUseCase.execute(
        const FetchHasRunningTackPayload(),
      );
      emit(
        state.copyWith(
          runningTackData: RunningTackData(
            hasRunningTack: hasRunningTack,
          ),
        ),
      );
    } catch (_) {
      emit(
        state.copyWith(
          runningTackData: const RunningTackData(
            hasError: true,
          ),
        ),
      );
    }
  }

  Future<void> _onFetchUserContactsAction(
    FetchUserContactsAction event,
    Emitter<OngoingRunnerTackState> emit,
  ) async {
    try {
      emit(state.copyWith(isContactsLoading: true));
      final UserContacts userContacts = await _fetchUserContactsUseCase.execute(
        FetchUserContactsPayload(
          tackId: state.runnerTack.tack.id,
        ),
      );
      emit(
        state.copyWith(
          userContacts: userContacts,
        ),
      );
    } catch (_) {
    } finally {
      emit(state.copyWith(isContactsLoading: false));
    }
  }

  Future<void> _onActionPressed(
    ActionPressed event,
    Emitter<OngoingRunnerTackState> emit,
  ) async {
    switch (state.runnerTack.tack.status) {
      case TackStatus.pendingStart:
        return __onStartTack();
      case TackStatus.inProgress:
        return __onCompleteTack();
      default:
        break;
    }
  }

  Future<void> __onStartTack() async {
    try {
      _appRouter.pushProgress();
      await _startTackUseCase.execute(
        StartTackPayload(tack: state.runnerTack.tack),
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

  Future<void> __onCompleteTack() async {
    try {
      _appRouter.pushProgress();
      await _completeTackUseCase.execute(
        CompleteTackPayload(tack: state.runnerTack.tack),
      );
      _appRouter.popProgress();
      _appRouter.removeNamed(
        OngoingRunnerTackFeature.routeName(
          id: state.runnerTack.id,
        ),
      );

      await _appRouter.pushForResult(
        RateTackUser.page(
          tack: state.runnerTack.tack,
          isRateTacker: true,
        ),
      );
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

  Future<void> _onMessageTacker(
    MessageTacker event,
    Emitter<OngoingRunnerTackState> emit,
  ) async {
    if (!state.hasContactData) return;

    final String phoneNumber = state.userContacts!.phoneNumber;
    PhoneUtility.sendSMS(phoneNumber);
  }

  Future<void> _onCallTacker(
    CallTacker event,
    Emitter<OngoingRunnerTackState> emit,
  ) async {
    if (!state.hasContactData) return;

    final String phoneNumber = state.userContacts!.phoneNumber;
    PhoneUtility.callNumber(phoneNumber);
  }

  Future<void> _onCancelTack(
    CancelTack event,
    Emitter<OngoingRunnerTackState> emit,
  ) async {
    final bool? result = await _appRouter.pushForResult(
      DestructiveDialog.page(
        DestructiveAlert(
          contentKey: 'destructiveAlert.cancelTackRunner',
          translationParams: <AlertPropertyKey, Map<String, String>>{
            AlertPropertyKey.message: <String, String>{
              'tackName': state.runnerTack.tack.title,
            },
          },
        ),
      ),
    );

    if (result != true) return;

    try {
      _appRouter.pushProgress();
      await _cancelTackUseCase.execute(
        CancelTackPayload(tack: state.runnerTack.tack),
      );
      _appRouter.popProgress();
      _appRouter.removeNamed(
        OngoingRunnerTackFeature.routeName(
          id: state.runnerTack.id,
        ),
      );
      _appRouter.pushForResult(
        AppAlertDialog.page(
          ErrorAlert(
            contentKey: 'errorAlert.tackCancel',
          ),
        ),
      );
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

  Future<void> _onTackIntentAction(
    TackIntentAction event,
    Emitter<OngoingRunnerTackState> emit,
  ) async {
    final WebSocketIntent<RunnerTack> intent = event.tackIntent;

    if (intent.objectId != state.runnerTack.id) return;

    switch (intent.action) {
      case WebSocketAction.create:
        return;
      case WebSocketAction.update:
        final RunnerTack newTack = intent.object!;

        return emit(
          state.copyWith(
            runnerTack: newTack,
            currentStep: newTack.tack.currentStepIndex(isTacker: false),
          ),
        );
      case WebSocketAction.delete:
        return _appRouter.removeNamed(
          OngoingRunnerTackFeature.routeName(
            id: state.runnerTack.id,
          ),
        );
    }
  }

  @override
  void onShouldRefresh() {
    add(const RefreshAction());
  }

  @override
  Future<void> close() async {
    _tackIntentSubscription.cancel();
    _appLifeCycleProvider.removeObserver(this);

    return super.close();
  }
}
