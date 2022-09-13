import 'package:core_ui/core_ui.dart';
import 'package:flutter/cupertino.dart';

import 'withdraw_successful_form.dart';

class WithdrawSuccessfulScreen extends StatelessWidget {
  final double? newTackBalance;

  const WithdrawSuccessfulScreen({
    Key? key,
    required this.newTackBalance,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: AppTheme.secondaryBackgroundColor,
      navigationBar: AppNavigationBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppTheme.secondaryBackgroundColor,
        withResult: false,
      ),
      child: SafeArea(
        child: WithdrawSuccessfulForm(
          newTackBalance: newTackBalance,
        ),
      ),
    );
  }
}
