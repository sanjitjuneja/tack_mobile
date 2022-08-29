part of payment;

class PaymentSetupIntent extends Equatable {
  final String clientSecret;

  const PaymentSetupIntent({
    required this.clientSecret,
  });

  @override
  List<Object?> get props => <Object?>[clientSecret];
}
