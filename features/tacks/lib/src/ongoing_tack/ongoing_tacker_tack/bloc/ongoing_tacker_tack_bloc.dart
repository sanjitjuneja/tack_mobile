import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:domain/domain.dart';
import 'package:navigation/navigation.dart';
import 'package:tacks/src/mocked_data/offers.dart';

import 'package:tacks/src/ongoing_tack/view_extensions/ongoing_tack_to_view_extension.dart';

part 'ongoing_tacker_tack_event.dart';

part 'ongoing_tacker_tack_state.dart';

class OngoingTackerTackBloc
    extends Bloc<OngoingTackerTackEvent, OngoingTackerTackState> {
  final AppRouterDelegate appRouter;

  OngoingTackerTackBloc({
    required Tack tack,
    required this.appRouter,
  }) : super(
          OngoingTackerTackState(
            tack: tack,
            stepsCount:
                OngoingTackToStepIndexViewExtension.tackerTackStepsCount,
            currentStep: tack.currentStepIndex(isTacker: true),
          ),
        ) {
    on<CancelTack>(_onCancelTack);
    on<ContactRunner>(_onContactRunner);
    on<LoadOffers>(_onLoadOffers);
    on<SelectOffer>(_onSelectOffer);

    if (tack.isChooseRunnerStage) {
      add(const LoadOffers());
    }
  }

  Future<void> _onCancelTack(
    CancelTack event,
    Emitter<OngoingTackerTackState> emit,
  ) async {
    final bool? result = await appRouter.pushForResult(
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
      appRouter.pop();
      appRouter.pushForResult(
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
    final String? phoneNumber = state.tack.runner?.contacts.phoneNumber;
    PhoneCallUtility.callNumber(phoneNumber);
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
