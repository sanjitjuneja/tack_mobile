import 'package:core_ui/core_ui.dart';
import 'package:flutter/cupertino.dart';

import 'sms_verification_form.dart';

class SmsVerificationScreen extends StatelessWidget {
  const SmsVerificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: AppTheme.secondaryBackgroundColor,
      navigationBar: AppNavigationBar(
        backgroundColor: AppTheme.secondaryBackgroundColor,
        withResult: true,
      ),
      child: const SafeArea(
        child: SmsVerificationForm(),
      ),
    );
  }
}
