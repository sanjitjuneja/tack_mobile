import 'package:core_ui/core_ui.dart';
import 'package:flutter/cupertino.dart';

import 'sign_in_form.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return KeyboardDismissible(
      child: CupertinoPageScaffold(
        backgroundColor: AppTheme.primaryColor,
        navigationBar: AppNavigationBar(
          backgroundColor: AppTheme.primaryColor,
          withResult: true,
        ),
        child: const SafeArea(
          child: SignInForm(),
        ),
      ),
    );
  }
}
