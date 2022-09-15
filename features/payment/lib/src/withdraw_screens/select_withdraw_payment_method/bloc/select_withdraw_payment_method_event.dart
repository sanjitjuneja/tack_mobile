part of 'select_withdraw_payment_method_bloc.dart';

abstract class SelectWithdrawPaymentMethodEvent {
  const SelectWithdrawPaymentMethodEvent();
}

class InitialLoad extends SelectWithdrawPaymentMethodEvent {
  const InitialLoad();
}

class ContinueAction extends SelectWithdrawPaymentMethodEvent {
  const ContinueAction();
}

class SelectWithdrawPaymentMethodAction
    extends SelectWithdrawPaymentMethodEvent {
  final ConnectedBankAccount? bankAccount;

  const SelectWithdrawPaymentMethodAction({
    required this.bankAccount,
  });
}

class AddBankAccountAction extends SelectWithdrawPaymentMethodEvent {
  const AddBankAccountAction();
}
