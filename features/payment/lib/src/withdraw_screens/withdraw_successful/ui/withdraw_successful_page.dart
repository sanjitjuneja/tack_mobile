import 'package:flutter/cupertino.dart';
import 'withdraw_successful_screen.dart';

class WithdrawSuccessfulFeature {
  static const String routeName = '/withdrawSuccessful';

  static Page<void> page({
    required double? newTackBalance,
  }) {
    return WithdrawSuccessfulPage(
      newTackBalance: newTackBalance,
    );
  }
}

class WithdrawSuccessfulPage extends Page<void> {
  final double? newTackBalance;

  @override
  String get name => WithdrawSuccessfulFeature.routeName;

  const WithdrawSuccessfulPage({
    required this.newTackBalance,
  });

  @override
  Route<void> createRoute(BuildContext context) {
    return CupertinoPageRoute<void>(
      settings: this,
      builder: (_) => WithdrawSuccessfulScreen(
        newTackBalance: newTackBalance,
      ),
    );
  }
}
