import 'package:core/core.dart';
import 'package:navigation/navigation.dart';

part 'add_payment_method_event.dart';

part 'add_payment_method_state.dart';

class AddPaymentMethodBloc
    extends Bloc<AddPaymentMethodEvent, AddPaymentMethodState> {
  final AppRouterDelegate _appRouter;

  AddPaymentMethodBloc({
    required AppRouterDelegate appRouter,
  })  : _appRouter = appRouter,
        super(const AddPaymentMethodState());
}
