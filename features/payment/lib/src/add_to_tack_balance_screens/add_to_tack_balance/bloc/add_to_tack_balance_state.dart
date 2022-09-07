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

  bool get isExistSelectedPaymentMethod {
    if (selectedPaymentMethod.card != null) return true;
    if (selectedPaymentMethod.bankAccount != null) return true;
    if (selectedPaymentMethod.isGooglePay) return true;
    if (selectedPaymentMethod.isApplePay) return true;

    return false;
  }

  String? get selectedPaymentMethodId {
    if (selectedPaymentMethod.card != null) {
      return selectedPaymentMethod.card!.id;
    } else if (selectedPaymentMethod.bankAccount != null) {
      return selectedPaymentMethod.bankAccount!.id;
    } else if (selectedPaymentMethod.isApplePay) {
      return Constants.applePayId;
    } else if (selectedPaymentMethod.isGooglePay) {
      return Constants.googlePayId;
    }

    return null;
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
