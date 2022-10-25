import 'package:domain/domain.dart';

class PayForTackSelectedPaymentMethod {
  final ConnectedBankAccount? bankAccount;
  final ConnectedCard? card;
  final bool isApplePay;
  final bool isGooglePay;
  final bool isTackBalance;

  bool get isBankAccount => bankAccount != null;

  bool get isCard => card != null;

  const PayForTackSelectedPaymentMethod({
    required this.bankAccount,
    required this.card,
    this.isApplePay = false,
    this.isGooglePay = false,
    this.isTackBalance = false,
  });
}
