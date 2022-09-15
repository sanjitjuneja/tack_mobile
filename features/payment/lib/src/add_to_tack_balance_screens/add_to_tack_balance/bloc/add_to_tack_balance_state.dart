part of 'add_to_tack_balance_bloc.dart';

class AddToTackBalanceState {
  final double amount;
  final Fee? fee;
  final UserBankAccount userBalance;
  final DepositSelectedPaymentMethod selectedPaymentMethod;
  final bool isLoading;
  final bool hasError;

  const AddToTackBalanceState({
    required this.amount,
    required this.selectedPaymentMethod,
    required this.userBalance,
    required this.fee,
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

  double get currentFeePercent {
    if (selectedPaymentMethod.bankAccount != null) {
      return fee?.dwollaFeeData.feePercent ?? 0;
    } else {
      return fee?.stripeFeeData.feePercent ?? 0;
    }
  }

  int get currentMinFeeAmount {
    if (selectedPaymentMethod.bankAccount != null) {
      return fee?.dwollaFeeData.feeMin ?? 0;
    } else {
      return fee?.stripeFeeData.feeMin ?? 0;
    }
  }

  int get currentMaxFeeAmount {
    if (selectedPaymentMethod.bankAccount != null) {
      return fee?.dwollaFeeData.feeMax ?? 0;
    } else {
      return fee?.stripeFeeData.feeMax ?? 0;
    }
  }

  double get amountInDollarFormatWithFee {
    double feeAmount = (currentFeePercent / 100) * amount;
    final double feeMinAmount = currentMinFeeAmount.toDouble().toDollarFormat;
    final double feeMaxAmount = currentMaxFeeAmount.toDouble().toDollarFormat;

    if (feeAmount > feeMaxAmount) {
      feeAmount = feeMinAmount;
    } else if (feeAmount < feeMinAmount) {
      feeAmount = feeMinAmount;
    }

    return amount + feeAmount;
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

  bool get isReadyToProceed => amount > 0 && isExistSelectedPaymentMethod;

  AddToTackBalanceState copyWith({
    double? amount,
    UserBankAccount? userBalance,
    Fee? fee,
    DepositSelectedPaymentMethod? selectedPaymentMethod,
    bool? isLoading,
    bool? hasError,
  }) {
    return AddToTackBalanceState(
      amount: amount ?? this.amount,
      userBalance: userBalance ?? this.userBalance,
      fee: fee ?? this.fee,
      selectedPaymentMethod:
          selectedPaymentMethod ?? this.selectedPaymentMethod,
      isLoading: isLoading ?? this.isLoading,
      hasError: hasError ?? this.hasError,
    );
  }
}
