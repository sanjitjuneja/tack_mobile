import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:domain/domain.dart';
import 'package:navigation/navigation.dart';

import 'package:tacks/src/add_edit_tack/ui/add_edit_tack_page.dart';
import 'package:tacks/src/mocked_data/offers.dart';
import 'package:tacks/src/ongoing_tack/view_extensions/ongoing_tack_to_view_extension.dart';
import 'package:tacks/src/rate_tack_user/ui/rate_tack_user_page.dart';

part 'ongoing_tacker_tack_event.dart';

part 'ongoing_tacker_tack_state.dart';

class OngoingTackerTackBloc
    extends Bloc<OngoingTackerTackEvent, OngoingTackerTackState> {
  final AppRouterDelegate _appRouter;

  OngoingTackerTackBloc({
    required Tack tack,
    required AppRouterDelegate appRouter,
  })  : _appRouter = appRouter,
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
    on<LoadOffers>(_onLoadOffers);
    on<SelectOffer>(_onSelectOffer);

    if (tack.isChooseRunnerStage) {
      add(const LoadOffers());
    }
  }

  Future<void> _onActionPressed(
    ActionPressed event,
    Emitter<OngoingTackerTackState> emit,
  ) async {
    switch (state.tack.status) {
      case TackStatus.created:
        _appRouter.pushForResult(AddEditTack.editPage(state.tack));
        break;
      case TackStatus.pendingReview:
        // TODO: action to complete tack.
        _appRouter.pushForResult(
          RateTackUser.page(
            tack: state.tack,
            isRateTacker: false,
          ),
        );
        break;
      default:
        break;
    }
  }

  Future<void> _onCancelTack(
    CancelTack event,
    Emitter<OngoingTackerTackState> emit,
  ) async {
    final bool? result = await _appRouter.pushForResult(
      DestructiveDialog.page(
        DestructiveAlert(
          contentKey: 'destructiveAlert.cancelTackTacker',
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

  Future<void> _onContactRunner(
    ContactRunner event,
    Emitter<OngoingTackerTackState> emit,
  ) async {
    // TODO: refactor when BE will fix
    // final String? phoneNumber = state.tack.runner?.contacts.phoneNumber;
    // PhoneCallUtility.callNumber(phoneNumber);
  }

  Future<void> _onLoadOffers(
    LoadOffers event,
    Emitter<OngoingTackerTackState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));
    // Simulate API call;
    await Future.delayed(const Duration(seconds: 2));

    emit(state.copyWith(offers: offers));
  }

  Future<void> _onSelectOffer(
    SelectOffer event,
    Emitter<OngoingTackerTackState> emit,
  ) async {
    // TODO: add logic to select offer.
  }
}
