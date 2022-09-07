part of 'add_to_tack_balance_bloc.dart';

class AddToTackBalanceState {
  final double amount;
  final UserBankAccount userBalance;
  final SelectedPaymentMethod selectedPaymentMethod;
  final bool isLoading;
  final bool hasError;

  const AddToTackBalanceState({
    required this.amount,
    required this.selectedPaymentMethod,
    required this.userBalance,
    this.isLoading = false,
    this.hasError = false,
  });

  bool get isExistsSelectedPaymentMethod {
    if (selectedPaymentMethod.card == null &&
        selectedPaymentMethod.bankAccount == null &&
        !selectedPaymentMethod.isGooglePay &&
        !selectedPaymentMethod.isApplePay) {
      return false;
    }
    return true;
  }

  AddToTackBalanceState copyWith({
    double? amount,
    UserBankAccount? userBalance,
    SelectedPaymentMethod? selectedPaymentMethod,
    bool? isLoading,
    bool? hasError,
  }) {
    return AddToTackBalanceState(
      amount: amount ?? this.amount,
      userBalance: userBalance ?? this.userBalance,
      selectedPaymentMethod:
          selectedPaymentMethod ?? this.selectedPaymentMethod,
      isLoading: isLoading ?? this.isLoading,
      hasError: hasError ?? this.hasError,
    );
  }
}
