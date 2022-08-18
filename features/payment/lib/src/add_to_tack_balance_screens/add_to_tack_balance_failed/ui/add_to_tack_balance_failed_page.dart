import 'package:flutter/cupertino.dart';
import 'add_to_tack_balance_failed_screen.dart';

class AddToTackBalanceFailedFeature {
  static const String routeName = '/addToTackBalanceFailed';

  static Page<void> page() => const AddToTackBalanceFailedPage();
}

class AddToTackBalanceFailedPage extends Page<void> {
  @override
  String get name => AddToTackBalanceFailedFeature.routeName;

  const AddToTackBalanceFailedPage();

  @override
  Route<void> createRoute(BuildContext context) {
    return CupertinoPageRoute<void>(
      settings: this,
      builder: (_) => const AddToTackBalanceFailedScreen(),
    );
  }
}
