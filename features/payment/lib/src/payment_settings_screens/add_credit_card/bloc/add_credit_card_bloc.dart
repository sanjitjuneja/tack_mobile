import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:domain/payment/payment.dart';
import 'package:domain/use_case.dart';
import 'package:navigation/navigation.dart';
import 'package:payment/src/payment_settings_screens/add_payment_method_screens/add_payment_method_failed/ui/add_payment_method_failed_page.dart';

part 'add_credit_card_event.dart';

part 'add_credit_card_state.dart';

class AddCreditCardBloc extends Bloc<AddCreditCardEvent, AddCreditCardState> {
  final AppRouterDelegate _appRouter;
  final AddCardUseCase _addCardUseCase;

  AddCreditCardBloc({
    required AppRouterDelegate appRouter,
    required AddCardUseCase addCardUseCase,
  })  : _appRouter = appRouter,
        _addCardUseCase = addCardUseCase,
        super(
          const AddCreditCardState(
            card: CardFieldInputDetails(complete: false),
          ),
        ) {
    on<AddCreditCardChange>(_onAddCreditCardChange);
    on<AddNewCreditCard>(_onAddNewCreditCard);
  }

  Future<void> _onAddCreditCardChange(
    AddCreditCardChange event,
    Emitter<AddCreditCardState> emit,
  ) async {
    if (event.card != null) emit(state.copyWith(card: event.card));
  }

  Future<void> _onAddNewCreditCard(
    AddNewCreditCard event,
    Emitter<AddCreditCardState> emit,
  ) async {
    try {
      _appRouter.push(ProgressDialog.page());
      final SetupIntent setupIntent = await _addCardUseCase.execute(NoParams());
      _appRouter.pop();
      //TODO: navigate to card info screen using setupIntent.paymentMethodId
    } catch (e) {
      _appRouter.pop();
      _appRouter.replace(AddPaymentMethodFailedFeature.page());
    }
  }
}
