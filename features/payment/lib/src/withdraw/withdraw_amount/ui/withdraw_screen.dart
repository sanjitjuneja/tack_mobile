import 'package:core_ui/core_ui.dart';
import 'package:flutter/cupertino.dart';
import 'withdraw_form.dart';

class WithdrawScreen extends StatelessWidget {
  const WithdrawScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: AppTheme.secondaryBackgroundColor,
      navigationBar: AppNavigationBar(
        backgroundColor: AppTheme.secondaryBackgroundColor,
        withResult: false,
      ),
      child: const SafeArea(
        child: WithdrawForm(),
      ),
    );
  }
}