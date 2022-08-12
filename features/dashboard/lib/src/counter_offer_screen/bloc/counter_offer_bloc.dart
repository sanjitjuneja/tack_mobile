import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:domain/domain.dart';
import 'package:navigation/navigation.dart';

import 'package:dashboard/src/counter_offer_screen/models/counter_offer_data.dart';

part 'counter_offer_event.dart';

part 'counter_offer_state.dart';

class CounterOfferBloc extends Bloc<CounterOfferEvent, CounterOfferState> {
  static const double _maxCounterOfferValue = 1000;

  final AppRouterDelegate _appRouter;
  final MakeOfferUseCase _makeOfferUseCase;

  CounterOfferBloc({
    required AppRouterDelegate appRouter,
    required MakeOfferUseCase makeOfferUseCase,
    required Tack tack,
  })  : _appRouter = appRouter,
        _makeOfferUseCase = makeOfferUseCase,
        super(
          CounterOfferState(
            tack: tack,
            counterOfferData: CounterOfferData(
              minValue: tack.price,
              maxValue: _maxCounterOfferValue,
              isValidationEnabled: false,
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
      state.copyWith(
        counterOffer: event.counterOffer,
        isValidationEnabled: false,
      ),
    );
  }

  Future<void> _onCounterOfferSend(
    CounterOfferSend event,
    Emitter<CounterOfferState> emit,
  ) async {
    emit(
      state.copyWith(isValidationEnabled: true),
    );
    if (state.counterOfferData.isInvalid) {
      return;
    }

    try {
      _appRouter.push(ProgressDialog.page());
      await _makeOfferUseCase.execute(
        MakeOfferPayload(
          tackId: state.tack.id,
          price: state.counterOfferData.parsedPrice,
        ),
      );
      _appRouter.pop();
      _appRouter.popWithResult(true);
    } catch (e) {
      _appRouter.pop();
      _appRouter.pushForResult(
        AppAlertDialog.page(
          ErrorAlert(
            contentKey: 'errorAlert.offerSending',
            messageKey: e.toString(),
          ),
        ),
      );
    }
  }
}
