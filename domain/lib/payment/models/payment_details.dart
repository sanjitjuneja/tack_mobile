part of payment;

class PaymentDetails extends Equatable {
  final String? paymentTransactionId;
  final AppPaymentMethod paymentMethod;

  const PaymentDetails({
    required this.paymentTransactionId,
    required this.paymentMethod,
  });

  @override
  List<Object?> get props => <Object?>[
        paymentTransactionId,
        paymentMethod,
      ];
}
