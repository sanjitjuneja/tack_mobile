import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:flutter/cupertino.dart';

import '../../bloc/onboarding_bloc.dart';

class OnboardingActions extends StatelessWidget {
  const OnboardingActions({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        AppCircleButton(
          labelKey: 'onboardingScreen.signUpButton',
          onTap: () => _onSignUpPressed(context),
        ),
        AppCircleButton(
          labelKey: 'onboardingScreen.signInButton',
          padding: const EdgeInsets.all(8),
          interfaceSize: AppInterfaceSize.small,
          backgroundColor: AppTheme.transparentColor,
          borderColor:  AppTheme.transparentColor,
          interfaceColor: AppTheme.textHintColor,
          onTap: () => _onSignInPressed(context),
        ),
      ],
    );
  }

  void _onSignUpPressed(BuildContext context) {
    BlocProvider.of<OnboardingBloc>(context).add(const SignUpAction());
  }

  void _onSignInPressed(BuildContext context) {
    BlocProvider.of<OnboardingBloc>(context).add(const SignInAction());
  }
}
