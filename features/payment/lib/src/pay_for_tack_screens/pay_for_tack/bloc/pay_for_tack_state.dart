part of 'pay_for_tack_bloc.dart';

class PayForTackState {
  final Fee? fee;
  final UserBankAccount userBalance;
  final PayForTackSelectedPaymentMethod selectedPaymentMethod;
  final Offer offer;
  final bool isLoading;
  final bool hasError;

  const PayForTackState({
    required this.selectedPaymentMethod,
    required this.userBalance,
    required this.fee,
    required this.offer,
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

  bool get isReadyToProceed => isExistSelectedPaymentMethod;

  PayForTackState copyWith({
    double? amount,
    UserBankAccount? userBalance,
    Fee? fee,
    Offer? offer,
    PayForTackSelectedPaymentMethod? selectedPaymentMethod,
    bool? isLoading,
    bool? hasError,
  }) {
    return PayForTackState(
      userBalance: userBalance ?? this.userBalance,
      fee: fee ?? this.fee,
      offer: offer ?? this.offer,
      selectedPaymentMethod:
          selectedPaymentMethod ?? this.selectedPaymentMethod,
      isLoading: isLoading ?? this.isLoading,
      hasError: hasError ?? this.hasError,
    );
  }
}
