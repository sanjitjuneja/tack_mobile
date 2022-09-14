import 'package:domain/domain.dart';

class PayForTackSelectedPaymentMethod {
  final ConnectedBankAccount? bankAccount;
  final ConnectedCard? card;
  final bool isApplePay;
  final bool isGooglePay;
  final bool isTackBalance;

  const PayForTackSelectedPaymentMethod({
    required this.bankAccount,
    required this.card,
    this.isApplePay = false,
    this.isGooglePay = false,
    this.isTackBalance = false,
  });
}
