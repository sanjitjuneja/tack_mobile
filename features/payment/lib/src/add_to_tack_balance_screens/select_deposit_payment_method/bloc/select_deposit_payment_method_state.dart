part of 'select_deposit_payment_method_bloc.dart';

class SelectDepositPaymentMethodState {
  final List<ConnectedBankAccount> bankAccounts;
  final List<ConnectedCard> cards;
  final String? selectedPaymentMethodId;
  final Fee? fee;
  final bool isLoading;
  final bool hasError;
  final bool isApplePaySupported;
  final bool isGooglePaySupported;

  bool get digitalWalletsSupported =>
      isApplePaySupported || isGooglePaySupported;

  DepositSelectedPaymentMethod? get selectedPaymentMethod {
    if (selectedPaymentMethodId == Constants.googlePayId) {
      return const DepositSelectedPaymentMethod(
        bankAccount: null,
        card: null,
        isGooglePay: true,
      );
    } else if (selectedPaymentMethodId == Constants.applePayId) {
      return const DepositSelectedPaymentMethod(
        bankAccount: null,
        card: null,
        isApplePay: true,
      );
    } else if (selectedPaymentMethodId != null) {
      for (final bankAccount in bankAccounts) {
        if (bankAccount.id == selectedPaymentMethodId) {
          return DepositSelectedPaymentMethod(
            bankAccount: bankAccount,
            card: null,
          );
        }
      }
      for (final card in cards) {
        if (card.id == selectedPaymentMethodId) {
          return DepositSelectedPaymentMethod(
            bankAccount: null,
            card: card,
          );
        }
      }
    }

    return null;
  }

  const SelectDepositPaymentMethodState({
    required this.bankAccounts,
    required this.cards,
    required this.selectedPaymentMethodId,
    required this.fee,
    this.isLoading = false,
    this.hasError = false,
    this.isApplePaySupported = false,
    this.isGooglePaySupported = false,
  });

  SelectDepositPaymentMethodState copyWith({
    List<ConnectedBankAccount>? bankAccounts,
    List<ConnectedCard>? cards,
    String? selectedPaymentMethodId,
    Fee? fee,
    bool? isLoading,
    bool? hasError,
    bool? isApplePaySupported,
    bool? isGooglePaySupported,
  }) {
    return SelectDepositPaymentMethodState(
      bankAccounts: bankAccounts ?? this.bankAccounts,
      cards: cards ?? this.cards,
      selectedPaymentMethodId:
          selectedPaymentMethodId ?? this.selectedPaymentMethodId,
      fee: fee ?? this.fee,
      isLoading: isLoading ?? this.isLoading,
      hasError: hasError ?? this.hasError,
      isApplePaySupported: isApplePaySupported ?? this.isApplePaySupported,
      isGooglePaySupported: isGooglePaySupported ?? this.isGooglePaySupported,
    );
  }
}
