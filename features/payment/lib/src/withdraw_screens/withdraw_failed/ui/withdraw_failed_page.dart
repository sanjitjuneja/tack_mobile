import 'package:flutter/cupertino.dart';
import 'withdraw_failed_screen.dart';

class WithdrawFailedFeature {
  static const String routeName = '/withdrawFailed';

  static Page<void> page() => const WithdrawFailedPage();
}

class WithdrawFailedPage extends Page<void> {
  @override
  String get name => WithdrawFailedFeature.routeName;

  const WithdrawFailedPage();

  @override
  Route<void> createRoute(BuildContext context) {
    return CupertinoPageRoute<void>(
      settings: this,
      builder: (_) => const WithdrawFailedScreen(),
    );
  }
}
