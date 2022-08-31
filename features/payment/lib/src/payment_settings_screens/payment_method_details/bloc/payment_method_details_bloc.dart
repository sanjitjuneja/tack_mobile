import 'package:core/core.dart';
import 'package:domain/domain.dart';
import 'package:navigation/navigation.dart';

part 'payment_method_details_state.dart';

part 'payment_method_details_event.dart';

class PaymentMethodDetailsBloc
    extends Bloc<PaymentMethodDetailsEvent, PaymentMethodDetailsState> {
  final AppRouterDelegate _appRouter;

  PaymentMethodDetailsBloc({
    required AppRouterDelegate appRouter,
    required AddCardUseCase addCardUseCase,
    required ConnectedCard? card,
    required ConnectedBankAccount? bankAccount,
  })  : _appRouter = appRouter,
        super(
          PaymentMethodDetailsState(
            card: card,
            bankAccount: bankAccount,
          ),
        );
}
