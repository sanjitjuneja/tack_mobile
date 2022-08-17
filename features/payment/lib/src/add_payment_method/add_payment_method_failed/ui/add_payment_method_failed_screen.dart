import 'package:core_ui/core_ui.dart';
import 'package:flutter/cupertino.dart';
import 'add_payment_method_failed_form.dart';

class AddPaymentMethodFailedScreen extends StatelessWidget {
  const AddPaymentMethodFailedScreen({Key? key}) : super(key: key);

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
        child: AddPaymentMethodFailedForm(),
      ),
    );
  }
}