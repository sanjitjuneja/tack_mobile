import 'package:core_ui/core_ui.dart';
import 'package:flutter/cupertino.dart';

import 'add_credit_card_form.dart';

class AddCreditCardScreen extends StatelessWidget {
  const AddCreditCardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: AppTheme.secondaryBackgroundColor,
      navigationBar: AppNavigationBar(
        backgroundColor: AppTheme.secondaryBackgroundColor,
        withResult: true,
      ),
      child: const SafeArea(
        child: AddCreditCardForm(),
      ),
    );
  }
}
