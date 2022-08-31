part of 'payment_method_details_bloc.dart';

class PaymentMethodDetailsState {
  final ConnectedCard? card;
  final ConnectedBankAccount? bankAccount;

  const PaymentMethodDetailsState({
    required this.card,
    required this.bankAccount,
  });

  bool get isBankAccount => bankAccount != null;

  PaymentMethodDetailsState copyWith({
    ConnectedCard? card,
    ConnectedBankAccount? bankAccount,
  }) {
    return PaymentMethodDetailsState(
      card: card ?? this.card,
      bankAccount: bankAccount ?? this.bankAccount,
    );
  }
}
