import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:domain/domain.dart';
import 'package:navigation/navigation.dart';

import '../../payment_settings/models/payment_method_details_screen_result.dart';

part 'payment_method_details_state.dart';

part 'payment_method_details_event.dart';

class PaymentMethodDetailsBloc
    extends Bloc<PaymentMethodDetailsEvent, PaymentMethodDetailsState> {
  final AppRouterDelegate _appRouter;
  final RemovePaymentMethodUseCase _removePaymentMethodUseCase;
  final SetPrimaryPaymentMethodUseCase _setPrimaryPaymentMethodUseCase;

  PaymentMethodDetailsBloc({
    required AppRouterDelegate appRouter,
    required RemovePaymentMethodUseCase removePaymentMethodUseCase,
    required SetPrimaryPaymentMethodUseCase setPrimaryPaymentMethodUseCase,
    required ConnectedCard? card,
    required ConnectedBankAccount? bankAccount,
  })  : _appRouter = appRouter,
        _removePaymentMethodUseCase = removePaymentMethodUseCase,
        _setPrimaryPaymentMethodUseCase = setPrimaryPaymentMethodUseCase,
        super(
          PaymentMethodDetailsState(
            card: card,
            bankAccount: bankAccount,
          ),
        ) {
    on<RemovePaymentMethodRequest>(_onRemovePaymentMethodRequest);
    on<SetPrimaryPaymentMethodRequest>(_onSetPrimaryPaymentMethodRequest);
  }

  Future<void> _onRemovePaymentMethodRequest(
    RemovePaymentMethodRequest event,
    Emitter<PaymentMethodDetailsState> emit,
  ) async {
    try {
      _appRouter.push(ProgressDialog.page());
      if (state.isBankAccount) {
        await _removePaymentMethodUseCase.execute(
          RemovePaymentMethodPayload(
            paymentMethodType: ConnectedPaymentMethodType.bank,
            paymentMethodId: state.bankAccount!.id,
          ),
        );
      } else {
        await _removePaymentMethodUseCase.execute(
          RemovePaymentMethodPayload(
            paymentMethodType: ConnectedPaymentMethodType.card,
            paymentMethodId: state.card!.id,
          ),
        );
      }
      final bool isPrimaryMethod = state.isBankAccount
          ? state.bankAccount!.isPrimary
          : state.card!.isPrimary;

      _appRouter.pop();
      _appRouter.popWithResult(
        isPrimaryMethod
            ? PaymentMethodDetailsScreenResult.removedPrimaryPaymentMethod
            : PaymentMethodDetailsScreenResult.removedPaymentMethod,
      );
    } catch (e) {
      _appRouter.pop();
    }
  }

  Future<void> _onSetPrimaryPaymentMethodRequest(
    SetPrimaryPaymentMethodRequest event,
    Emitter<PaymentMethodDetailsState> emit,
  ) async {
    try {
      _appRouter.push(ProgressDialog.page());
      if (state.isBankAccount) {
        await _setPrimaryPaymentMethodUseCase.execute(
          SetPrimaryPaymentMethodPayload(
            paymentMethodType: ConnectedPaymentMethodType.bank,
            paymentMethodId: state.bankAccount!.id,
          ),
        );
      } else {
        await _setPrimaryPaymentMethodUseCase.execute(
          SetPrimaryPaymentMethodPayload(
            paymentMethodType: ConnectedPaymentMethodType.card,
            paymentMethodId: state.card!.id,
          ),
        );
      }
      _appRouter.pop();
      _appRouter.popWithResult(PaymentMethodDetailsScreenResult.setPrimary);
    } catch (e) {
      _appRouter.pop();
    }
  }
}
