part of 'withdraw_bloc.dart';

class WithdrawState {
  final List<ConnectedBankAccount> bankAccounts;
  final ConnectedBankAccount? selectedBankAccount;
  final double withdrawAmount;
  final Fee? fee;
  final UserBankAccount userBalance;
  final bool isLoading;
  final bool hasError;

  bool get isReadyToProceed =>
      withdrawAmount > 0 && selectedBankAccount != null;

  double get maxWithdrawLimit =>
      min(userBalance.usdBalance, Constants.maxWithdrawLimitAmount);

  const WithdrawState({
    required this.bankAccounts,
    required this.selectedBankAccount,
    required this.fee,
    required this.withdrawAmount,
    required this.userBalance,
    this.isLoading = false,
    this.hasError = false,
  });

  WithdrawState copyWith({
    List<ConnectedBankAccount>? bankAccounts,
    ConnectedBankAccount? selectedBankAccount,
    double? withdrawAmount,
    UserBankAccount? userBalance,
    Fee? fee,
    bool? isLoading,
    bool? hasError,
  }) {
    return WithdrawState(
      bankAccounts: bankAccounts ?? this.bankAccounts,
      selectedBankAccount: selectedBankAccount ?? this.selectedBankAccount,
      withdrawAmount: withdrawAmount ?? this.withdrawAmount,
      userBalance: userBalance ?? this.userBalance,
      fee: fee ?? this.fee,
      isLoading: isLoading ?? this.isLoading,
      hasError: hasError ?? this.hasError,
    );
  }
}
