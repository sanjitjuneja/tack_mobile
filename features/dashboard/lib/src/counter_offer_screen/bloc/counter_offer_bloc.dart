import 'dart:math';

import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:domain/domain.dart';
import 'package:navigation/navigation.dart';

part 'counter_offer_event.dart';

part 'counter_offer_state.dart';

class CounterOfferBloc extends Bloc<CounterOfferEvent, CounterOfferState> {
  final AppRouterDelegate appRouter;

  CounterOfferBloc({
    required this.appRouter,
    required TackModel tack,
  }) : super(
          CounterOfferState(tack: tack),
        ) {
    on<CounterOfferChange>(_onCounterOfferChange);
    on<CounterOfferSend>(_onCounterOfferSend);
  }

  Future<void> _onCounterOfferChange(
    CounterOfferChange event,
    Emitter<CounterOfferState> emit,
  ) async {
    emit(
      state.copyWith(counterOffer: event.counterOffer),
    );
  }

  Future<void> _onCounterOfferSend(
    CounterOfferSend event,
    Emitter<CounterOfferState> emit,
  ) async {
    appRouter.push(ProgressDialog.page());
    // API request simulation.
    await Future.delayed(const Duration(seconds: 1));
    appRouter.pop();

    const List<dynamic> answers = <dynamic>['some error', false, true];
    final dynamic answer = answers[Random().nextInt(answers.length)];

    if (answer is String) {
      appRouter.push(
        AppAlertDialog.page(
          DestructiveAlert(
            contentKey: 'test',
            title: 'Offer Not Sent',
            message: 'Sorry, smth went wrong, try again.',
            buttonLabel: 'Close',
          ),
        ),
      );
    } else {
      appRouter.popWithResult(answer);
    }
  }
}
