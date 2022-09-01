part of 'payment_settings_bloc.dart';

abstract class PaymentSettingsEvent {
  const PaymentSettingsEvent();
}

class InitialLoad extends PaymentSettingsEvent {
  const InitialLoad();
}

class FetchUserBalanceAction extends PaymentSettingsEvent {
  const FetchUserBalanceAction();
}

class AddCashAction extends PaymentSettingsEvent {
  const AddCashAction();
}

class PayoutAction extends PaymentSettingsEvent {
  const PayoutAction();
}

class AddPaymentMethodAction extends PaymentSettingsEvent {
  const AddPaymentMethodAction();
}

class PaymentMethodDetailsAction extends PaymentSettingsEvent {
  final ConnectedCard? card;
  final ConnectedBankAccount? bankAccount;

  const PaymentMethodDetailsAction({
    this.card,
    this.bankAccount,
  });
}

class UserBalanceUpdate extends PaymentSettingsEvent {
  final UserBankAccount userBalance;

  const UserBalanceUpdate({
    required this.userBalance,
  });
}
