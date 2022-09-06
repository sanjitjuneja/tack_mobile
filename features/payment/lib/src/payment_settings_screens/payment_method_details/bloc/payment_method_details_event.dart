part of 'payment_method_details_bloc.dart';

abstract class PaymentMethodDetailsEvent {
  const PaymentMethodDetailsEvent();
}

class RemovePaymentMethodRequest extends PaymentMethodDetailsEvent {
  final ConnectedBankAccount? bankAccount;
  final ConnectedCard? card;

  const RemovePaymentMethodRequest({
    required this.bankAccount,
    required this.card,
  });
}

class SetPrimaryPaymentMethodRequest extends PaymentMethodDetailsEvent {
  final ConnectedBankAccount? bankAccount;
  final ConnectedCard? card;

  const SetPrimaryPaymentMethodRequest({
    required this.bankAccount,
    required this.card,
  });
}
