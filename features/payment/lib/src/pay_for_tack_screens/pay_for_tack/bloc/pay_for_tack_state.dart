part of 'pay_for_tack_bloc.dart';

class PayForTackState {
  final Fee? fee;
  final UserBankAccount userBalance;
  final PayForTackSelectedPaymentMethod selectedPaymentMethod;
  final Offer offer;
  final double tackPrice;
  final bool isLoading;
  final bool hasError;

  const PayForTackState({
    required this.selectedPaymentMethod,
    required this.userBalance,
    required this.fee,
    required this.offer,
    required this.tackPrice,
    this.isLoading = false,
    this.hasError = false,
  });

  bool get isExistSelectedPaymentMethod {
    if (selectedPaymentMethod.card != null) return true;
    if (selectedPaymentMethod.bankAccount != null) return true;
    if (selectedPaymentMethod.isGooglePay) return true;
    if (selectedPaymentMethod.isApplePay) return true;
    if (selectedPaymentMethod.isTackBalance) return true;

    return false;
  }

  double get tackOfferPrice => offer.price ?? tackPrice;

  bool get hasEnoughTackBalance => userBalance.usdBalance >= tackOfferPrice;

  double amountInDollarFormatWithFee({
    required double feePercent,
    required double feeMinAmount,
    required double feeMaxAmount,
  }) {
    double feeAmount = (feePercent / 100) * tackOfferPrice;
    if (feeAmount > feeMaxAmount.toDollarFormat) {
      feeAmount = feeMaxAmount;
    } else if (feeAmount < feeMinAmount.toDollarFormat) {
      feeAmount = feeMinAmount;
    }

    return tackOfferPrice + feeAmount;
  }

  double get currentFeePercent {
    if (selectedPaymentMethod.isTackBalance) {
      return 0;
    } else if (selectedPaymentMethod.bankAccount != null) {
      return fee?.dwollaFeeData.feePercent ?? 0;
    } else {
      return fee?.stripeFeeData.feePercent ?? 0;
    }
  }

  String? get selectedPaymentMethodId {
    if (selectedPaymentMethod.isTackBalance) {
      return Constants.tackBalance;
    } else if (selectedPaymentMethod.card != null) {
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
    double? tackPrice,
    PayForTackSelectedPaymentMethod? selectedPaymentMethod,
    bool? isLoading,
    bool? hasError,
  }) {
    return PayForTackState(
      userBalance: userBalance ?? this.userBalance,
      fee: fee ?? this.fee,
      offer: offer ?? this.offer,
      tackPrice: tackPrice ?? this.tackPrice,
      selectedPaymentMethod:
          selectedPaymentMethod ?? this.selectedPaymentMethod,
      isLoading: isLoading ?? this.isLoading,
      hasError: hasError ?? this.hasError,
    );
  }
}
