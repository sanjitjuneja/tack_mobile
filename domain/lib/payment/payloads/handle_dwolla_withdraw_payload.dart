part of payment;

class HandleDwollaWithdrawPayload {
  final String paymentMethodId;
  final double amountInCents;
  final String currency;

  const HandleDwollaWithdrawPayload({
    required this.paymentMethodId,
    required this.amountInCents,
    required this.currency,
  });
}