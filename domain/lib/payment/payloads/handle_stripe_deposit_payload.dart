part of payment;

class HandleStripeDepositPayload {
  final String paymentMethodId;
  final double amountInCents;
  final String currency;
  final double amountWithFeeInCents;

  const HandleStripeDepositPayload({
    required this.paymentMethodId,
    required this.amountInCents,
    required this.currency,
    required this.amountWithFeeInCents,
  });
}
