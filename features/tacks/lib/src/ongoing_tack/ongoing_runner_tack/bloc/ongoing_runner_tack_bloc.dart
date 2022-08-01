import 'dart:async';

import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:domain/domain.dart';
import 'package:navigation/navigation.dart';

import 'package:tacks/src/ongoing_tack/view_extensions/ongoing_tack_to_view_extension.dart';
import 'package:tacks/src/rate_tack_user/ui/rate_tack_user_page.dart';

part 'ongoing_runner_tack_event.dart';

part 'ongoing_runner_tack_state.dart';

class OngoingRunnerTackBloc
    extends Bloc<OngoingRunnerTackEvent, OngoingRunnerTackState> {
  final AppRouterDelegate _appRouter;
  final TacksRepository _tacksRepository;

  static bool _hasInProgressRunnerTack(List<RunnerTack> tacks) {
    return tacks.any((element) => element.tack.status == TackStatus.inProgress);
  }

  OngoingRunnerTackBloc({
    required Tack tack,
    required AppRouterDelegate appRouter,
    required TacksRepository tacksRepository,
  })  : _appRouter = appRouter,
        _tacksRepository = tacksRepository,
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
    on<ActionPressed>(_onActionPressed);
    on<ContactTacker>(_onContactTacker);
    on<CancelTack>(_onCancelTack);
  }

  Future<void> _onActionPressed(
      ActionPressed event,
      Emitter<OngoingRunnerTackState> emit,
      ) async {
    switch (state.tack.status) {
      case TackStatus.pendingStart:
        // TODO: action to begin tack.
        break;
      case TackStatus.inProgress:
        // TODO: action to complete tack.
        _appRouter.pushForResult(
          RateTackUser.page(
            tack: state.tack,
            isRateTacker: true,
          ),
        );
        break;
      default:
        break;
    }
  }

  Future<void> _onContactTacker(
    ContactTacker event,
    Emitter<OngoingRunnerTackState> emit,
  ) async {
    final String? phoneNumber = state.tack.tacker.contacts.phoneNumber;
    PhoneCallUtility.callNumber(phoneNumber);
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
            AlertPropertyKey.message: {'tackName': state.tack.title},
          },
        ),
      ),
    );

    if (result == true) {
      // TODO: add request for cancelling tack.
      _appRouter.pop();
      _appRouter.pushForResult(
        AppAlertDialog.page(
          ErrorAlert(contentKey: 'errorAlert.tackCanceled'),
        ),
      );
    }
  }
}
