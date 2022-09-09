import 'package:flutter/cupertino.dart';
import 'add_to_tack_balance_successful_screen.dart';

class AddToTackBalanceSuccessfulFeature {
  static const String routeName = '/addToTackBalanceSuccessful';

  static Page<void> page({
    required double newTackBalance,
  }) {
    return AddToTackBalanceSuccessfulPage(
      newTackBalance: newTackBalance,
    );
  }
}

class AddToTackBalanceSuccessfulPage extends Page<void> {
  final double newTackBalance;

  @override
  String get name => AddToTackBalanceSuccessfulFeature.routeName;

  const AddToTackBalanceSuccessfulPage({
    required this.newTackBalance,
  });

  @override
  Route<void> createRoute(BuildContext context) {
    return CupertinoPageRoute<void>(
      settings: this,
      builder: (_) => AddToTackBalanceSuccessfulScreen(
        newTackBalance: newTackBalance,
      ),
    );
  }
}
