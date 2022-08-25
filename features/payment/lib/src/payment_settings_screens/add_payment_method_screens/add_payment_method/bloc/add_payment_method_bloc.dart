import 'dart:async';

import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:domain/payment/payment.dart';
import 'package:navigation/navigation.dart';
import 'package:payment/src/payment_settings_screens/add_credit_card/ui/add_credit_card_page.dart';

import '../../add_payment_method_failed/ui/add_payment_method_failed_page.dart';

part 'add_payment_method_event.dart';

part 'add_payment_method_state.dart';

class AddPaymentMethodBloc
    extends Bloc<AddPaymentMethodEvent, AddPaymentMethodState> {
  final AppRouterDelegate _appRouter;
  final AddBankAccountUseCase _addBankAccountUseCase;

  AddPaymentMethodBloc({
    required AppRouterDelegate appRouter,
    required AddBankAccountUseCase addBankAccountUseCase,
  })  : _appRouter = appRouter,
        _addBankAccountUseCase = addBankAccountUseCase,
        super(
          const AddPaymentMethodState(),
        ) {
    on<AddCreditCardRequest>(_onAddCreditCardRequest);
    on<AddBankAccountRequest>(_onAddBankAccountRequest);
  }

  Future<void> _onAddCreditCardRequest(
    AddCreditCardRequest event,
    Emitter<AddPaymentMethodState> emit,
  ) async {
    _appRouter.push(AddCreditCardFeature.page());
  }

  Future<void> _onAddBankAccountRequest(
    AddBankAccountRequest event,
    Emitter<AddPaymentMethodState> emit,
  ) async {
    try {
      _appRouter.push(ProgressDialog.page());
      final List<ConnectedBankAccount>? bankAccounts =
          await _addBankAccountUseCase.execute(
        const AddBankAccountPayload(),
      );
      _appRouter.pop();
      if (bankAccounts == null) {
        _appRouter.replace(AddPaymentMethodFailedFeature.page());
      } else if (bankAccounts.isEmpty) {
        _appRouter.replace(
          AddPaymentMethodFailedFeature.page(
            labelKey: 'addPaymentMethodFailedScreen.depositoryDescription',
          ),
        );
      } else {
        //TODO: navigate to payment settings screen
      }
    } catch (e) {
      _appRouter.pop();
      _appRouter.replace(AddPaymentMethodFailedFeature.page());
    }
  }
}
