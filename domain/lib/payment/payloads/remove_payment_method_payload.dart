part of payment;

class RemovePaymentMethodPayload {
  final ConnectedPaymentMethodType paymentMethodType;
  final String paymentMethodId;

  const RemovePaymentMethodPayload({
    required this.paymentMethodType,
    required this.paymentMethodId,
  });
}
