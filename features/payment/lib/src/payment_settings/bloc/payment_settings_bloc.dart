import 'package:core/core.dart';
import 'package:navigation/navigation.dart';
import '/src/add_payment_method/ui/add_payment_method_page.dart';

part 'payment_settings_event.dart';

part 'payment_settings_state.dart';

class PaymentSettingsBloc
    extends Bloc<PaymentSettingsEvent, PaymentSettingsState> {
  final AppRouterDelegate _appRouter;

  PaymentSettingsBloc({
    required AppRouterDelegate appRouter,
  })  : _appRouter = appRouter,
        super(const PaymentSettingsState()) {
    on<AddPaymentMethodRequest>(_onAddPaymentMethodRequest);
  }

  Future<void> _onAddPaymentMethodRequest(
    AddPaymentMethodRequest event,
    Emitter<PaymentSettingsState> emit,
  ) async {
    _appRouter.push(AddPaymentMethodFeature.page());
  }
}
