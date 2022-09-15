part of 'select_pay_for_tack_payment_method_bloc.dart';

abstract class SelectPayForTackPaymentMethodEvent {
  const SelectPayForTackPaymentMethodEvent();
}

class InitialLoad extends SelectPayForTackPaymentMethodEvent {
  const InitialLoad();
}

class SelectPayForTackPaymentMethodAction
    extends SelectPayForTackPaymentMethodEvent {
  final String paymentMethodId;

  const SelectPayForTackPaymentMethodAction({
    required this.paymentMethodId,
  });
}

class AddPaymentMethodAction extends SelectPayForTackPaymentMethodEvent {
  const AddPaymentMethodAction();
}

class ContinueAction extends SelectPayForTackPaymentMethodEvent {
  const ContinueAction();
}

class UserBalanceUpdate extends SelectPayForTackPaymentMethodEvent {
  final UserBankAccount userBalance;

  const UserBalanceUpdate({
    required this.userBalance,
  });
}
