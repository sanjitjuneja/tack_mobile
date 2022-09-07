import 'package:domain/domain.dart';

class SelectedPaymentMethod {
  final ConnectedBankAccount? bankAccount;
  final ConnectedCard? card;
  final bool isApplePay;
  final bool isGooglePay;

  const SelectedPaymentMethod({
    required this.bankAccount,
    required this.card,
    this.isApplePay = false,
    this.isGooglePay = false,
  });
}
