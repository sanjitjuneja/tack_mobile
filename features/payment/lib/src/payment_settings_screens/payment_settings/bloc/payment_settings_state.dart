part of 'payment_settings_bloc.dart';

class PaymentSettingsState {
  final List<ConnectedBankAccount> bankAccounts;
  final List<ConnectedCard> cards;
  final UserBankAccount userBalance;
  final bool isLoading;
  final bool hasError;
  final bool isApplePaySupported;
  final bool isGooglePaySupported;

  bool get digitalWalletsSupported =>
      isApplePaySupported || isGooglePaySupported;

  bool get isPrimaryMethodExists {
    for (final bankAccount in bankAccounts) {
      if (bankAccount.isPrimary) {
        return true;
      }
    }
    for (final card in cards) {
      if (card.isPrimary) {
        return true;
      }
    }
    return false;
  }

  const PaymentSettingsState({
    required this.bankAccounts,
    required this.cards,
    required this.userBalance,
    this.isLoading = false,
    this.hasError = false,
    this.isApplePaySupported = false,
    this.isGooglePaySupported = false,
  });

  PaymentSettingsState copyWith({
    List<ConnectedBankAccount>? bankAccounts,
    List<ConnectedCard>? cards,
    UserBankAccount? userBalance,
    bool? isLoading,
    bool? hasError,
    bool? isApplePaySupported,
    bool? isGooglePaySupported,
  }) {
    return PaymentSettingsState(
      bankAccounts: bankAccounts ?? this.bankAccounts,
      cards: cards ?? this.cards,
      userBalance: userBalance ?? this.userBalance,
      isLoading: isLoading ?? this.isLoading,
      hasError: hasError ?? this.hasError,
      isApplePaySupported: isApplePaySupported ?? this.isApplePaySupported,
      isGooglePaySupported: isGooglePaySupported ?? this.isGooglePaySupported,
    );
  }
}
