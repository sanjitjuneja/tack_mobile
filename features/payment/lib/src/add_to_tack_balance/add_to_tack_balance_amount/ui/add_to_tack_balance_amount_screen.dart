import 'package:core_ui/core_ui.dart';
import 'package:flutter/cupertino.dart';
import 'add_to_tack_balance_amount_form.dart';

class AddToTackBalanceAmountScreen extends StatelessWidget {
  const AddToTackBalanceAmountScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: AppTheme.secondaryBackgroundColor,
      navigationBar: AppNavigationBar(
        backgroundColor: AppTheme.secondaryBackgroundColor,
        withResult: false,
      ),
      child: const SafeArea(
        child: AddToTackBalanceAmountForm(),
      ),
    );
  }
}