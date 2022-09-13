import 'package:core_ui/core_ui.dart';
import 'package:flutter/cupertino.dart';

import 'add_payment_method_form.dart';

class AddPaymentMethodScreen extends StatelessWidget {
  const AddPaymentMethodScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: AppTheme.secondaryBackgroundColor,
      navigationBar: AppNavigationBar(
        backgroundColor: AppTheme.secondaryBackgroundColor,
        withResult: false,
      ),
      child: const SafeArea(
        child: AddPaymentMethodForm(),
      ),
    );
  }
}