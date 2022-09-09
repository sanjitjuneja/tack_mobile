import 'package:flutter/cupertino.dart';
import 'add_to_tack_balance_failed_screen.dart';

class AddToTackBalanceFailedFeature {
  static const String routeName = '/addToTackBalanceFailed';

  static Page<void> page({
    required String errorKey,
  }) {
    return AddToTackBalanceFailedPage(
      errorKey: errorKey,
    );
  }
}

class AddToTackBalanceFailedPage extends Page<void> {
  final String errorKey;

  @override
  String get name => AddToTackBalanceFailedFeature.routeName;

  const AddToTackBalanceFailedPage({
    required this.errorKey,
  });

  @override
  Route<void> createRoute(BuildContext context) {
    return CupertinoPageRoute<void>(
      settings: this,
      builder: (_) => AddToTackBalanceFailedScreen(
        errorKey: errorKey,
      ),
    );
  }
}
