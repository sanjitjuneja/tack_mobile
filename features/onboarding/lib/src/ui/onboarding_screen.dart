import 'package:core_ui/core_ui.dart';
import 'package:flutter/cupertino.dart';

import 'onboarding_form.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: AppTheme.secondaryBackgroundColor,
      navigationBar: AppNavigationBar(
        backgroundColor: AppTheme.secondaryBackgroundColor,
        automaticallyImplyLeading: false,
        withTransition: false,
      ),
      child: const SafeArea(
        child: OnboardingForm(),
      ),
    );
  }
}
