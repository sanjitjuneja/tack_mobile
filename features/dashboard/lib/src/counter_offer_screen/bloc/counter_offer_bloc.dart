import 'dart:math';

import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:dashboard/src/counter_offer_screen/models/counter_offer_data.dart';
import 'package:domain/domain.dart';
import 'package:navigation/navigation.dart';

part 'counter_offer_event.dart';

part 'counter_offer_state.dart';

class CounterOfferBloc extends Bloc<CounterOfferEvent, CounterOfferState> {
  static const double _maxCounterOfferValue = 1000;

  final AppRouterDelegate appRouter;

  CounterOfferBloc({
    required this.appRouter,
    required Tack tack,
  }) : super(
          CounterOfferState(
            tack: tack,
            counterOfferData: const CounterOfferData(
              maxValue: _maxCounterOfferValue,
              isRequired: true,
            ),
          ),
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
      appRouter.pushForResult(
        AppAlertDialog.page(
          ErrorAlert(
            contentKey: 'errorAlert.offerSending',
          ),
        ),
      );
    } else {
      appRouter.popWithResult(answer);
    }
  }
}
