part of payment;

class HandleDwollaDepositPayload {
  final String paymentMethodId;
  final double amountInCents;
  final String currency;

  const HandleDwollaDepositPayload({
    required this.paymentMethodId,
    required this.amountInCents,
    required this.currency,
  });
}
