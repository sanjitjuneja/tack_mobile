part of 'payment_settings_bloc.dart';

class PaymentSettingsState {
  final List<ConnectedBankAccount> bankAccounts;
  final List<ConnectedCard> cards;
  final bool isLoading;
  final bool hasError;
  final bool isApplePaySupported;
  final bool isGooglePaySupported;

  const PaymentSettingsState({
    required this.bankAccounts,
    required this.cards,
    this.isLoading = false,
    this.hasError = false,
    this.isApplePaySupported = false,
    this.isGooglePaySupported = false,
  });

  PaymentSettingsState copyWith({
    List<ConnectedBankAccount>? bankAccounts,
    List<ConnectedCard>? cards,
    bool? isLoading,
    bool? hasError,
    bool? isApplePaySupported,
    bool? isGooglePaySupported,
  }) {
    return PaymentSettingsState(
      bankAccounts: bankAccounts ?? this.bankAccounts,
      cards: cards ?? this.cards,
      isLoading: isLoading ?? this.isLoading,
      hasError: hasError ?? this.hasError,
      isApplePaySupported: isApplePaySupported ?? this.isApplePaySupported,
      isGooglePaySupported: isGooglePaySupported ?? this.isGooglePaySupported,
    );
  }
}
