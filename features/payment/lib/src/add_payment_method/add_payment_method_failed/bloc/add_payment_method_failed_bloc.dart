import 'package:core/core.dart';
import 'package:navigation/navigation.dart';

part 'add_payment_method_failed_event.dart';
part 'add_payment_method_failed_state.dart';

class AddPaymentMethodFailedBloc
    extends Bloc<AddPaymentMethodFailedEvent, AddPaymentMethodFailedState> {
  final AppRouterDelegate _appRouter;

  AddPaymentMethodFailedBloc({
    required AppRouterDelegate appRouter,
  })  : _appRouter = appRouter,
        super(const AddPaymentMethodFailedState()) {
    on<CloseRequest>(_onCloseRequest);
  }

  Future<void> _onCloseRequest(
      CloseRequest event,
      Emitter<AddPaymentMethodFailedState> emit,
      ) async {
    _appRouter.pop();
  }
}
