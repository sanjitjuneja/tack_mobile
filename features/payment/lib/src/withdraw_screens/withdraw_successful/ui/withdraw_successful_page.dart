import 'package:flutter/cupertino.dart';

import 'withdraw_successful_screen.dart';

class WithdrawSuccessfulFeature {
  static const String routeName = '/withdrawSuccessful';

  static Page<void> page() => const WithdrawSuccessfulPage();
}

class WithdrawSuccessfulPage extends Page<void> {
  @override
  String get name => WithdrawSuccessfulFeature.routeName;

  const WithdrawSuccessfulPage();

  @override
  Route<void> createRoute(BuildContext context) {
    return CupertinoPageRoute<void>(
      settings: this,
      builder: (_) => const WithdrawSuccessfulScreen(),
    );
  }
}
