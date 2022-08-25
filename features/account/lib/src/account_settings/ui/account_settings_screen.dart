import 'package:account/src/account_settings/ui/account_settings_form.dart';
import 'package:core_ui/core_ui.dart';
import 'package:flutter/cupertino.dart';

class AccountSettingsScreen extends StatelessWidget {
  const AccountSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return KeyboardDismissible(
      child: CupertinoPageScaffold(
        backgroundColor: AppTheme.secondaryBackgroundColor,
        navigationBar: AppNavigationBar(
          backgroundColor: AppTheme.secondaryBackgroundColor,
          withResult: true,
        ),
        child: const SafeArea(
          child: AccountSettingsForm(),
        ),
      ),
    );
  }
}
