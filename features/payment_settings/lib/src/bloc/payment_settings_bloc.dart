import 'package:core/core.dart';
import 'package:navigation/navigation.dart';

part 'payment_settings_event.dart';

part 'payment_settings_state.dart';

class PaymentSettingsBloc extends Bloc<PaymentSettingsEvent, PaymentSettingsState> {
  final AppRouterDelegate appRouter;

  PaymentSettingsBloc({
    required this.appRouter,
  }) : super(const PaymentSettingsState());
}
