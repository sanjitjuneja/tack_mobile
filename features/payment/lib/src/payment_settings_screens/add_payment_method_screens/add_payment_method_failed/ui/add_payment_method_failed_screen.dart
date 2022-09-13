import 'package:core_ui/core_ui.dart';
import 'package:flutter/cupertino.dart';

import 'add_payment_method_failed_form.dart';

class AddPaymentMethodFailedScreen extends StatelessWidget {
  final String titleKey;
  final String descriptionKey;

  const AddPaymentMethodFailedScreen({
    Key? key,
    required this.titleKey,
    required this.descriptionKey,
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
        child: AddPaymentMethodFailedForm(
          titleKey: titleKey,
          descriptionKey: descriptionKey,
        ),
      ),
    );
  }
}
