import 'package:core_ui/core_ui.dart';
import 'package:flutter/cupertino.dart';

import 'phone_verification_form.dart';

class PhoneVerificationScreen extends StatelessWidget {
  const PhoneVerificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: AppTheme.secondaryBackgroundColor,
      navigationBar: AppNavigationBar(
        backgroundColor: AppTheme.secondaryBackgroundColor,
        withResult: true,
      ),
      child: const SafeArea(
        child: PhoneVerificationForm(),
      ),
    );
  }
}
