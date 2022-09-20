part of 'select_deposit_payment_method_bloc.dart';

abstract class SelectDepositPaymentMethodEvent {
  const SelectDepositPaymentMethodEvent();
}

class InitialLoad extends SelectDepositPaymentMethodEvent {
  const InitialLoad();
}

class SelectDepositPaymentMethodAction extends SelectDepositPaymentMethodEvent {
  final String paymentMethodId;

  const SelectDepositPaymentMethodAction({
    required this.paymentMethodId,
  });
}

class AddPaymentMethodAction extends SelectDepositPaymentMethodEvent{
  const AddPaymentMethodAction();
}

class AddBankAction extends SelectDepositPaymentMethodEvent {
  const AddBankAction();
}

class AddCardAction extends SelectDepositPaymentMethodEvent {
  const AddCardAction();
}

class ContinueAction extends SelectDepositPaymentMethodEvent {
  const ContinueAction();
}
