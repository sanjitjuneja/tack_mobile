import 'package:core_ui/core_ui.dart';
import 'package:flutter/cupertino.dart';

import 'auth_error_form.dart';

class AuthErrorScreen extends StatelessWidget {
  const AuthErrorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: AppTheme.primaryColor,
      navigationBar: AppNavigationBar(
        backgroundColor: AppTheme.primaryColor,
        withResult: true,
      ),
      child: const SafeArea(
        child: AuthErrorForm(),
      ),
    );
  }

}