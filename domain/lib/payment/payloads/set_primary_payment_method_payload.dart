part of payment;

class SetPrimaryPaymentMethodPayload {
  final ConnectedPaymentMethodType paymentMethodType;
  final String paymentMethodId;

  const SetPrimaryPaymentMethodPayload({
    required this.paymentMethodType,
    required this.paymentMethodId,
  });
}
