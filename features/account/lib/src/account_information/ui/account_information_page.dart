import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:flutter/cupertino.dart';
import 'package:navigation/navigation.dart';

import '../../account_settings/ui/account_settings_page.dart';
import 'account_information_screen.dart';

class AccountInformationFeature {
  static const String routeName = '/accountInformation';

  static Page<void> page() {
    return const AccountInformationPage();
  }
}

class AccountInformationPage extends Page<void> {
  @override
  String get name => AccountInformationFeature.routeName;

  const AccountInformationPage();

  @override
  Route<void> createRoute(BuildContext context) {
    return CupertinoPageRoute<void>(
      settings: this,
      builder: (_) => CupertinoPageScaffold(
        backgroundColor: AppTheme.secondaryBackgroundColor,
        navigationBar: AppNavigationBar(
          backgroundColor: AppTheme.secondaryBackgroundColor,
          actions: <Widget>[
            CupertinoButton(
              padding: const EdgeInsets.symmetric(vertical: 10),
              onPressed: () {
                appLocator
                    .get<AppRouterDelegate>()
                    .push(const AccountSettingsPage());
              },
              child: AppIconsTheme.editPencil(
                color: AppTheme.iconPrimaryColor,
              ),
            ),
          ],
        ),
        child: const AccountInformationScreen(),
      ),
    );
  }
}
