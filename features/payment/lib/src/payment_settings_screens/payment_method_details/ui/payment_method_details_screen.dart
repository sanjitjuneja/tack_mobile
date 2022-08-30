import 'package:core_ui/core_ui.dart';
import 'package:domain/payment/payment.dart';
import 'package:flutter/cupertino.dart';
import 'payment_method_details_form.dart';

class PaymentMethodDetailsScreen extends StatelessWidget {
  final ConnectedCard? card;
  final ConnectedBankAccount? bankAccount;

  const PaymentMethodDetailsScreen({
    Key? key,
    required this.card,
    required this.bankAccount,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: AppTheme.secondaryBackgroundColor,
      navigationBar: AppNavigationBar(
        backgroundColor: AppTheme.secondaryBackgroundColor,
        withResult: false,
      ),
      child: SafeArea(
        child: PaymentMethodDetailsForm(
          card: card,
          bankAccount: bankAccount,
        ),
      ),
    );
  }
}
