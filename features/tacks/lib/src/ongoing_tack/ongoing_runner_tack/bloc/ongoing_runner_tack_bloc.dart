import 'dart:async';

import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:domain/domain.dart';
import 'package:navigation/navigation.dart';

import '../../models/ongoing_runner_screen_result.dart';
import '../../view_extensions/ongoing_tack_to_view_extension.dart';
import '../../../rate_tack_user/ui/rate_tack_user_page.dart';

part 'ongoing_runner_tack_event.dart';

part 'ongoing_runner_tack_state.dart';

class OngoingRunnerTackBloc
    extends Bloc<OngoingRunnerTackEvent, OngoingRunnerTackState> {
  final AppRouterDelegate _appRouter;
  final FetchUserContactsUseCase _fetchUserContactsUseCase;
  final CancelTackRunnerUseCase _cancelTackUseCase;
  final CompleteTackRunnerUseCase _completeTackUseCase;
  final StartTackRunnerUseCase _startTackUseCase;

  static bool _hasInProgressRunnerTack(List<RunnerTack> tacks) {
    return tacks.any(
      (element) => element.tack.status == TackStatus.inProgress,
    );
  }

  OngoingRunnerTackBloc({
    required Tack tack,
    required AppRouterDelegate appRouter,
    required FetchUserContactsUseCase fetchUserContactsUseCase,
    required CancelTackRunnerUseCase cancelTackRunnerUseCase,
    required CompleteTackRunnerUseCase completeTackUseCase,
    required StartTackRunnerUseCase startTackUseCase,
    required TacksRepository tacksRepository,
  })  : _appRouter = appRouter,
        _fetchUserContactsUseCase = fetchUserContactsUseCase,
        _cancelTackUseCase = cancelTackRunnerUseCase,
        _completeTackUseCase = completeTackUseCase,
        _startTackUseCase = startTackUseCase,
        super(
          OngoingRunnerTackState(
            tack: tack,
            stepsCount:
                OngoingTackToStepIndexViewExtension.runnerTackStepsCount,
            currentStep: tack.currentStepIndex(isTacker: false),
            hasRunningTack: _hasInProgressRunnerTack(
              tacksRepository.runnerTacksStream.value,
            ),
          ),
        ) {
    on<FetchUserContactsAction>(_onFetchUserContactsAction);

    on<ActionPressed>(_onActionPressed);
    on<ContactTacker>(_onContactTacker);
    on<CancelTack>(_onCancelTack);

    add(const FetchUserContactsAction());
  }

  Future<void> _onFetchUserContactsAction(
    FetchUserContactsAction event,
    Emitter<OngoingRunnerTackState> emit,
  ) async {
    try {
      final UserContacts userContacts = await _fetchUserContactsUseCase.execute(
        FetchUserContactsPayload(
          tackId: state.tack.id,
        ),
      );
      emit(
        state.copyWith(
          userContacts: userContacts,
        ),
      );
    } catch (_) {}
  }

  Future<void> _onActionPressed(
    ActionPressed event,
    Emitter<OngoingRunnerTackState> emit,
  ) async {
    switch (state.tack.status) {
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
      _appRouter.push(ProgressDialog.page());
      await _startTackUseCase.execute(
        StartTackPayload(tack: state.tack),
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

  Future<void> __onCompleteTack() async {
    try {
      _appRouter.push(ProgressDialog.page());
      await _completeTackUseCase.execute(
        CompleteTackPayload(tack: state.tack),
      );
      _appRouter.pop();

      await _appRouter.pushForResult(
        RateTackUser.page(
          tack: state.tack,
          isRateTacker: true,
        ),
      );

      _appRouter.popWithResult(OngoingRunnerScreenResult.complete);
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

  Future<void> _onContactTacker(
    ContactTacker event,
    Emitter<OngoingRunnerTackState> emit,
  ) async {
    if (!state.hasContactData) return;

    final String phoneNumber = state.userContacts!.phoneNumber;
    PhoneCallUtility.callNumber(phoneNumber);
  }

  Future<void> _onCancelTack(
    CancelTack event,
    Emitter<OngoingRunnerTackState> emit,
  ) async {
    final bool result = await _appRouter.pushForResult(
      DestructiveDialog.page(
        DestructiveAlert(
          contentKey: 'destructiveAlert.cancelTackRunner',
          translationParams: <AlertPropertyKey, Map<String, String>>{
            AlertPropertyKey.message: {'tackName': state.tack.title},
          },
        ),
      ),
    );

    if (!result) return;

    try {
      _appRouter.push(ProgressDialog.page());
      await _cancelTackUseCase.execute(
        CancelTackPayload(tack: state.tack),
      );
      _appRouter.pop();
      _appRouter.popWithResult(OngoingRunnerScreenResult.cancel);
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
}
