import 'package:core_ui/core_ui.dart';
import 'package:flutter/cupertino.dart';

import 'onboarding_form.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppTheme.secondaryBackgroundColor,
      navigationBar: AppNavigationBar(
        backgroundColor: AppTheme.secondaryBackgroundColor,
        automaticallyImplyLeading: false,
        withTransition: false,
      ),
      child: const SafeArea(
        maintainBottomViewPadding: true,
        child: OnboardingForm(),
      ),
    );
  }
}
