import 'package:flutter/cupertino.dart';
import 'add_to_tack_balance_successful_screen.dart';

class AddToTackBalanceSuccessfulFeature {
  static const String routeName = '/addToTackBalanceSuccessful';

  static Page<void> page() => const AddToTackBalanceSuccessfulPage();
}

class AddToTackBalanceSuccessfulPage extends Page<void> {
  @override
  String get name => AddToTackBalanceSuccessfulFeature.routeName;

  const AddToTackBalanceSuccessfulPage();

  @override
  Route<void> createRoute(BuildContext context) {
    return CupertinoPageRoute<void>(
      settings: this,
      builder: (_) => const AddToTackBalanceSuccessfulScreen(),
    );
  }
}
