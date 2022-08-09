import 'package:core_ui/core_ui.dart';
import 'package:flutter/cupertino.dart';
import 'payment_settings_screen.dart';

class PaymentSettingsFeature {
  static const String routeName = '/paymentSettings';

  static Page<void> page() => const PaymentSettingsPage();
}

class PaymentSettingsPage extends Page<void> {
  @override
  String get name => PaymentSettingsFeature.routeName;

  const PaymentSettingsPage();

  @override
  Route<void> createRoute(BuildContext context) {
    return CupertinoPageRoute<void>(
      settings: this,
      builder: (_) => CupertinoPageScaffold(
        backgroundColor: AppTheme.secondaryBackgroundColor,
        navigationBar: AppNavigationBar(
          backgroundColor: AppTheme.secondaryBackgroundColor,
        ),
        child: const PaymentSettingsScreen(),
      ),
    );
  }
}
