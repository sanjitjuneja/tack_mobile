import 'package:core_ui/core_ui.dart';
import 'package:flutter/cupertino.dart';

import 'payment_method_details_form.dart';

class PaymentMethodDetailsScreen extends StatelessWidget {
  const PaymentMethodDetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: AppTheme.secondaryBackgroundColor,
      navigationBar: AppNavigationBar(
        backgroundColor: AppTheme.secondaryBackgroundColor,
        withResult: false,
      ),
      child: const SafeArea(
        child: PaymentMethodDetailsForm(),
      ),
    );
  }
}
