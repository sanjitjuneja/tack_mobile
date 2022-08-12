import 'package:core_ui/core_ui.dart';
import 'package:flutter/cupertino.dart';
import 'payment_settings_form.dart';

class PaymentSettingsScreen extends StatelessWidget {
  const PaymentSettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: AppTheme.secondaryBackgroundColor,
      navigationBar: AppNavigationBar(
        backgroundColor: AppTheme.secondaryBackgroundColor,
        withResult: false,
      ),
      child: const SafeArea(
        child: PaymentSettingsForm(),
      ),
    );
  }
}
