part of 'select_pay_for_tack_payment_method_bloc.dart';

class SelectPayForTackPaymentMethodState {
  final List<ConnectedBankAccount> bankAccounts;
  final List<ConnectedCard> cards;
  final UserBankAccount userBalance;
  final double offerPrice;
  final String? selectedPaymentMethodId;
  final Fee? fee;
  final bool isLoading;
  final bool hasError;
  final bool isApplePaySupported;
  final bool isGooglePaySupported;

  bool get digitalWalletsSupported =>
      isApplePaySupported || isGooglePaySupported;

  bool get hasEnoughTackBalance => userBalance.usdBalance >= offerPrice;

  PayForTackSelectedPaymentMethod? get selectedPaymentMethod {
    if (selectedPaymentMethodId == Constants.tackBalance) {
      return const PayForTackSelectedPaymentMethod(
        bankAccount: null,
        card: null,
        isTackBalance: true,
      );
    } else if (selectedPaymentMethodId == Constants.googlePayId) {
      return const PayForTackSelectedPaymentMethod(
        bankAccount: null,
        card: null,
        isGooglePay: true,
      );
    } else if (selectedPaymentMethodId == Constants.applePayId) {
      return const PayForTackSelectedPaymentMethod(
        bankAccount: null,
        card: null,
        isApplePay: true,
      );
    } else if (selectedPaymentMethodId != null) {
      for (final bankAccount in bankAccounts) {
        if (bankAccount.id == selectedPaymentMethodId) {
          return PayForTackSelectedPaymentMethod(
            bankAccount: bankAccount,
            card: null,
          );
        }
      }
      for (final card in cards) {
        if (card.id == selectedPaymentMethodId) {
          return PayForTackSelectedPaymentMethod(
            bankAccount: null,
            card: card,
          );
        }
      }
    }

    return null;
  }

  const SelectPayForTackPaymentMethodState({
    required this.bankAccounts,
    required this.cards,
    required this.selectedPaymentMethodId,
    required this.fee,
    required this.userBalance,
    required this.offerPrice,
    this.isLoading = false,
    this.hasError = false,
    this.isApplePaySupported = false,
    this.isGooglePaySupported = false,
  });

  SelectPayForTackPaymentMethodState copyWith({
    List<ConnectedBankAccount>? bankAccounts,
    List<ConnectedCard>? cards,
    UserBankAccount? userBalance,
    double? offerPrice,
    String? selectedPaymentMethodId,
    Fee? fee,
    bool? isLoading,
    bool? hasError,
    bool? isApplePaySupported,
    bool? isGooglePaySupported,
  }) {
    return SelectPayForTackPaymentMethodState(
      bankAccounts: bankAccounts ?? this.bankAccounts,
      cards: cards ?? this.cards,
      userBalance: userBalance ?? this.userBalance,
      offerPrice: offerPrice ?? this.offerPrice,
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
