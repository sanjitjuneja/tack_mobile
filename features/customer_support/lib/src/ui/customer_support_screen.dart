import 'package:core_ui/core_ui.dart';
import 'package:flutter/cupertino.dart';

import 'customer_support_form.dart';

class CustomerSupportScreen extends StatelessWidget {
  const CustomerSupportScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: AppTheme.primaryBackgroundColor,
      navigationBar: AppNavigationBar(
        backgroundColor: AppTheme.primaryBackgroundColor,
      ),
      child: const SafeArea(
        child: CustomerSupportForm(),
      ),
    );
  }
}
