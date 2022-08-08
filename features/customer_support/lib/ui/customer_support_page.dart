import 'package:core_ui/core_ui.dart';
import 'package:flutter/cupertino.dart';

import 'customer_support_screen.dart';

class CustomerSupportPage extends Page<void> {
  const CustomerSupportPage();

  @override
  Route<void> createRoute(BuildContext context) {
    return CupertinoPageRoute<void>(
      settings: this,
      builder: (_) => CupertinoPageScaffold(
        backgroundColor: AppTheme.primaryBackgroundColor,
        navigationBar: AppNavigationBar(
          backgroundColor: AppTheme.primaryBackgroundColor,
        ),
        child: const CustomerSupportScreen(),
      ),
    );
  }
}
