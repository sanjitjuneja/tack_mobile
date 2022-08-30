import 'package:core/core.dart';
import 'package:domain/payment/payment.dart';
import 'package:navigation/navigation.dart';

part 'payment_method_details_state.dart';

part 'payment_method_details_event.dart';

class PaymentMethodDetailsBloc
    extends Bloc<PaymentMethodDetailsEvent, PaymentMethodDetailsState> {
  final AppRouterDelegate _appRouter;

  PaymentMethodDetailsBloc({
    required AppRouterDelegate appRouter,
    required AddCardUseCase addCardUseCase,
  })  : _appRouter = appRouter,
        super(
          const PaymentMethodDetailsState(),
        ) {}
}
