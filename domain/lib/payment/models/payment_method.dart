part of payment;

class PaymentMethod {
  final String title;
  final String expiryDate;
  final String lastFourNumbers;
  final PaymentMethodType paymentMethodType;

  const PaymentMethod({
    required this.title,
    required this.expiryDate,
    required this.lastFourNumbers,
    required this.paymentMethodType,
  });
}
