import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:flutter/cupertino.dart';
import 'package:navigation/navigation.dart';

import '../bloc/onboarding_bloc.dart';
import 'onboarding_screen.dart';

class OnboardingFeature {
  static const String routeName = '/onboarding';

  static Page<void> page() {
    return const _OnboardingPage();
  }
}

class _OnboardingPage extends Page<void> {
  const _OnboardingPage();

  @override
  String get name => OnboardingFeature.routeName;

  @override
  Route<void> createRoute(BuildContext context) {
    return OpacityRoute<void>(
      settings: this,
      builder: (_) {
        return BlocProvider<OnboardingBloc>(
          create: (BuildContext context) => OnboardingBloc(
            globalAppRouter: appLocator.get<GlobalAppRouterDelegate>(),
          ),
          child: const OnboardingScreen(),
        );
      },
    );
  }
}
