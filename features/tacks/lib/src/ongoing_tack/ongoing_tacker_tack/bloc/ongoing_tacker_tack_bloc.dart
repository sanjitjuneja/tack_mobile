import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:domain/domain.dart';
import 'package:navigation/navigation.dart';

import 'package:tacks/src/add_edit_tack/ui/add_edit_tack_page.dart';
import 'package:tacks/src/ongoing_tack/models/ongoing_tacker_screen_result.dart';
import 'package:tacks/src/ongoing_tack/view_extensions/ongoing_tack_to_view_extension.dart';
import 'package:tacks/src/rate_tack_user/ui/rate_tack_user_page.dart';

part 'ongoing_tacker_tack_event.dart';

part 'ongoing_tacker_tack_state.dart';

class OngoingTackerTackBloc
    extends Bloc<OngoingTackerTackEvent, OngoingTackerTackState> {
  final AppRouterDelegate _appRouter;
  final CancelTackTackerUseCase _cancelTackUseCase;
  final AcceptOfferUseCase _acceptOfferUseCase;
  final CompleteTackTackerUseCase _completeTackUseCase;

  OngoingTackerTackBloc({
    required Tack tack,
    required AppRouterDelegate appRouter,
    required CancelTackTackerUseCase cancelTackTackerUseCase,
    required AcceptOfferUseCase acceptOfferUseCase,
    required CompleteTackTackerUseCase completeTackUseCase,
  })  : _appRouter = appRouter,
        _cancelTackUseCase = cancelTackTackerUseCase,
        _acceptOfferUseCase = acceptOfferUseCase,
        _completeTackUseCase = completeTackUseCase,
        super(
          OngoingTackerTackState(
            tack: tack,
            stepsCount:
                OngoingTackToStepIndexViewExtension.tackerTackStepsCount,
            currentStep: tack.currentStepIndex(isTacker: true),
          ),
        ) {
    on<ActionPressed>(_onActionPressed);
    on<CancelTack>(_onCancelTack);
    on<ContactRunner>(_onContactRunner);
    on<SelectOffer>(_onSelectOffer);
  }

  Future<void> _onActionPressed(
    ActionPressed event,
    Emitter<OngoingTackerTackState> emit,
  ) async {
    switch (state.tack.status) {
      case TackStatus.created:
        return __onEditTack(emit);
      case TackStatus.pendingReview:
        return __onCompleteTack();
      default:
        break;
    }
  }

  Future<void> __onEditTack(Emitter<OngoingTackerTackState> emit) async {
    final Tack? tack = await _appRouter.pushForResult(
      AddEditTack.editPage(state.tack),
    );

    if (tack != null) emit(state.copyWith(tack: tack));
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
          isRateTacker: false,
        ),
      );

      _appRouter.popWithResult(OngoingTackerScreenResult.complete);
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

  Future<void> _onCancelTack(
    CancelTack event,
    Emitter<OngoingTackerTackState> emit,
  ) async {
    final bool result = await _appRouter.pushForResult(
      DestructiveDialog.page(
        DestructiveAlert(
          contentKey: 'destructiveAlert.cancelTackTacker',
          translationParams: <AlertPropertyKey, Map<String, String>>{
            AlertPropertyKey.message: {
              'tackName': state.tack.title,
            },
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
      _appRouter.popWithResult(OngoingTackerScreenResult.cancel);
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

  Future<void> _onContactRunner(
    ContactRunner event,
    Emitter<OngoingTackerTackState> emit,
  ) async {
    // TODO: refactor when BE will fix
    // final String? phoneNumber = state.tack.runner?.contacts.phoneNumber;
    // PhoneCallUtility.callNumber(phoneNumber);
  }

  Future<void> _onSelectOffer(
    SelectOffer event,
    Emitter<OngoingTackerTackState> emit,
  ) async {
    try {
      _appRouter.push(ProgressDialog.page());
      await _acceptOfferUseCase.execute(
        AcceptOfferPayload(offer: event.offer),
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
}
