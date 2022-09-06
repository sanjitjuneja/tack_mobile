import 'package:core_ui/core_ui.dart';
import 'package:flutter/cupertino.dart';

import 'forgot_password_form.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return KeyboardDismissible(
      child: CupertinoPageScaffold(
        backgroundColor: AppTheme.secondaryBackgroundColor,
        navigationBar: AppNavigationBar(
          backgroundColor: AppTheme.secondaryBackgroundColor,
          withResult: true,
        ),
        child: const SafeArea(
          child: ForgotPasswordForm(),
        ),
      ),
    );
  }
}
