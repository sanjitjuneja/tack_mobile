import 'package:core_ui/core_ui.dart';
import 'package:flutter/cupertino.dart';

import 'add_to_tack_balance_failed_form.dart';

class AddToTackBalanceFailedScreen extends StatelessWidget {
  final String errorKey;

  const AddToTackBalanceFailedScreen({
    Key? key,
    required this.errorKey,
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
        child: AddToTackBalanceFailedForm(
          errorKey: errorKey,
        ),
      ),
    );
  }
}
