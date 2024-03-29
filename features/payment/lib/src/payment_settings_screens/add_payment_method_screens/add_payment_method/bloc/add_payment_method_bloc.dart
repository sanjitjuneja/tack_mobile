import 'dart:async';

import 'package:core/core.dart';
import 'package:domain/payment/payment.dart';
import 'package:navigation/navigation.dart';

import '../../../../../payment.dart';
import '../../../../payment_settings_screens/add_credit_card/ui/add_credit_card_page.dart';
import '../../add_payment_method_failed/ui/add_payment_method_failed_page.dart';

part 'add_payment_method_event.dart';

part 'add_payment_method_state.dart';

class AddPaymentMethodBloc
    extends Bloc<AddPaymentMethodEvent, AddPaymentMethodState> {
  final AppRouterDelegate _appRouter;
  final AddBankAccountUseCase _addBankAccountUseCase;
  final int _bankAccountsAmount;

  AddPaymentMethodBloc({
    required AppRouterDelegate appRouter,
    required AddBankAccountUseCase addBankAccountUseCase,
    required int bankAccountsAmount,
  })  : _appRouter = appRouter,
        _addBankAccountUseCase = addBankAccountUseCase,
        _bankAccountsAmount = bankAccountsAmount,
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
    final bool? result = await _appRouter.pushForResult(
      AddCreditCardFeature.page(),
    );
    if (result == true) {
      _appRouter.popWithResult(AddPaymentMethodScreenResult.card);
    } else {
      _appRouter.popWithResult(null);
    }
  }

  Future<void> _onAddBankAccountRequest(
    AddBankAccountRequest event,
    Emitter<AddPaymentMethodState> emit,
  ) async {
    try {
      if (_bankAccountsAmount >= Constants.maxBankAccountsAmount) {
        _appRouter.push(
          AddPaymentMethodFailedFeature.page(
            titleKey: 'addPaymentMethodFailedScreen.limitReached',
            descriptionKey: 'addPaymentMethodFailedScreen.limitDescription',
          ),
        );
      } else {
        _appRouter.pushProgress();
        final List<ConnectedBankAccount>? bankAccounts =
            await _addBankAccountUseCase.execute(
          const AddBankAccountPayload(),
        );
        _appRouter.popProgress();
        if (bankAccounts != null) {
          if (bankAccounts.isEmpty) {
            _appRouter.push(
              AddPaymentMethodFailedFeature.page(
                titleKey: 'addPaymentMethodFailedScreen.unableToAdd',
                descriptionKey:
                    'addPaymentMethodFailedScreen.depositoryDescription',
              ),
            );
          } else {
            _appRouter.popWithResult(AddPaymentMethodScreenResult.bankAccount);
          }
        }
      }
    } catch (e) {
      _appRouter.popProgress();
      _appRouter.push(
        AddPaymentMethodFailedFeature.page(
          titleKey: 'addPaymentMethodFailedScreen.unableToAdd',
          descriptionKey: 'addPaymentMethodFailedScreen.description',
        ),
      );
    }
  }
}
