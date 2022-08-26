import 'package:flutter/cupertino.dart';
import 'package:payment/src/withdraw_screens/withdraw/widgets/withdraw_method_type.dart';
import 'withdraw_successful_screen.dart';

class WithdrawSuccessfulFeature {
  static const String routeName = '/withdrawSuccessful';

  static Page<void> page({
    required WithdrawMethodType withdrawMethodType,
  }) {
    return WithdrawSuccessfulPage(
      withdrawMethodType: withdrawMethodType,
    );
  }
}

class WithdrawSuccessfulPage extends Page<void> {
  final WithdrawMethodType withdrawMethodType;

  @override
  String get name => WithdrawSuccessfulFeature.routeName;

  const WithdrawSuccessfulPage({
    required this.withdrawMethodType,
  });

  @override
  Route<void> createRoute(BuildContext context) {
    return CupertinoPageRoute<void>(
      settings: this,
      builder: (_) => WithdrawSuccessfulScreen(
        withdrawMethodType: withdrawMethodType,
      ),
    );
  }
}
