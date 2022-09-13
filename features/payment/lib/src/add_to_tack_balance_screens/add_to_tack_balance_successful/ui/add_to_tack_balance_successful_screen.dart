import 'package:core_ui/core_ui.dart';
import 'package:flutter/cupertino.dart';

import 'add_to_tack_balance_successful_form.dart';

class AddToTackBalanceSuccessfulScreen extends StatelessWidget {
  final double newTackBalance;

  const AddToTackBalanceSuccessfulScreen({
    Key? key,
    required this.newTackBalance,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: AppTheme.secondaryBackgroundColor,
      navigationBar: AppNavigationBar(
        backgroundColor: AppTheme.secondaryBackgroundColor,
        withResult: false,
        automaticallyImplyLeading: false,
      ),
      child: SafeArea(
        child: AddToTackBalanceSuccessfulForm(
          newTackBalance: newTackBalance,
        ),
      ),
    );
  }
}
