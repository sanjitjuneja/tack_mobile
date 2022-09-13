part of 'select_withdraw_payment_method_bloc.dart';

class SelectWithdrawPaymentMethodState {
  final List<ConnectedBankAccount> bankAccounts;
  final ConnectedBankAccount? selectedBankAccount;
  final Fee? fee;
  final bool isLoading;
  final bool hasError;

  const SelectWithdrawPaymentMethodState({
    required this.bankAccounts,
    required this.selectedBankAccount,
    required this.fee,
    this.isLoading = false,
    this.hasError = false,
  });

  SelectWithdrawPaymentMethodState copyWith({
    List<ConnectedBankAccount>? bankAccounts,
    ConnectedBankAccount? selectedBankAccount,
    Fee? fee,
    bool? isLoading,
    bool? hasError,
  }) {
    return SelectWithdrawPaymentMethodState(
      bankAccounts: bankAccounts ?? this.bankAccounts,
      selectedBankAccount:
          selectedBankAccount ?? this.selectedBankAccount,
      fee: fee ?? this.fee,
      isLoading: isLoading ?? this.isLoading,
      hasError: hasError ?? this.hasError,
    );
  }
}
