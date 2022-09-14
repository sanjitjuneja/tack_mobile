import 'package:domain/domain.dart';

class DepositSelectedPaymentMethod {
  final ConnectedBankAccount? bankAccount;
  final ConnectedCard? card;
  final bool isApplePay;
  final bool isGooglePay;

  const DepositSelectedPaymentMethod({
    required this.bankAccount,
    required this.card,
    this.isApplePay = false,
    this.isGooglePay = false,
  });
}
