import 'package:core_ui/core_ui.dart';
import 'package:flutter/cupertino.dart';

import 'sign_up_form.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return KeyboardDismissible(
      child: CupertinoPageScaffold(
        backgroundColor: AppTheme.positiveColor,
        navigationBar: AppNavigationBar(
          backgroundColor: AppTheme.primaryColor,
          withResult: true,
        ),
        child: const SafeArea(
          child: SignUpForm(),
        ),
      ),
    );
  }
}
