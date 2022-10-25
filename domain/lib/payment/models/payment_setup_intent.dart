part of payment;

class PaymentSetupIntent extends Equatable {
  final String transactionId;
  final String clientSecret;

  const PaymentSetupIntent({
    required this.transactionId,
    required this.clientSecret,
  });

  @override
  List<Object?> get props => <Object?>[
        transactionId,
        clientSecret,
      ];
}
