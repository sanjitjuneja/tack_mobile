import 'package:core_ui/core_ui.dart';
import 'package:flutter/cupertino.dart';
import 'withdraw_failed_form.dart';

class WithdrawFailedScreen extends StatelessWidget {
  const WithdrawFailedScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: AppTheme.secondaryBackgroundColor,
      navigationBar: AppNavigationBar(
        backgroundColor: AppTheme.secondaryBackgroundColor,
        withResult: false,
        automaticallyImplyLeading: false,
      ),
      child: const SafeArea(
        child: WithdrawFailedForm(),
      ),
    );
  }
}
