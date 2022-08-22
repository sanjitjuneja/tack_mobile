import 'package:core/core.dart';
import 'package:navigation/navigation.dart';
import 'package:payment/src/payment_settings_screens/add_credit_card/bloc/add_credit_card_bloc.dart';
import 'package:payment/src/payment_settings_screens/add_credit_card/ui/add_credit_card_page.dart';

part 'add_payment_method_event.dart';

part 'add_payment_method_state.dart';

class AddPaymentMethodBloc
    extends Bloc<AddPaymentMethodEvent, AddPaymentMethodState> {
  final AppRouterDelegate _appRouter;

  AddPaymentMethodBloc({
    required AppRouterDelegate appRouter,
  })  : _appRouter = appRouter,
        super(
          const AddPaymentMethodState(),
        ) {
    on<AddCreditCardRequest>(_onAddCreditCardRequest);
  }

  Future<void> _onAddCreditCardRequest(
    AddCreditCardRequest event,
    Emitter<AddPaymentMethodState> emit,
  ) async {
    _appRouter.push(AddCreditCardFeature.page());
  }
}
