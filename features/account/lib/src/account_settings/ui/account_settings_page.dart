import 'package:core_ui/core_ui.dart';
import 'package:flutter/cupertino.dart';

import 'account_settings_screen.dart';

class AccountSettingsPage extends Page<void> {
  const AccountSettingsPage();

  @override
  Route<void> createRoute(BuildContext context) {
    return CupertinoPageRoute<void>(
      settings: this,
      builder: (_) => CupertinoPageScaffold(
        backgroundColor: AppTheme.secondaryBackgroundColor,
        navigationBar: AppNavigationBar(
          backgroundColor: AppTheme.secondaryBackgroundColor,
        ),
        child: const AccountSettingsScreen(),
      ),
    );
  }
}
