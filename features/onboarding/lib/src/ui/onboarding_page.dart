import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:domain/domain.dart';
import 'package:flutter/cupertino.dart';
import 'package:navigation/navigation.dart';

import '../bloc/onboarding_bloc.dart';
import 'onboarding_screen.dart';

class OnboardingFeature {
  static const String routeName = '/onboarding';

  static Page<void> page({
    bool withSlideAnimation = false,
  }) {
    return _OnboardingPage(
      withSlideAnimation: withSlideAnimation,
    );
  }
}

class _OnboardingPage extends Page<void> {
  final bool withSlideAnimation;

  const _OnboardingPage({
    required this.withSlideAnimation,
  });

  @override
  String get name => OnboardingFeature.routeName;

  @override
  Route<void> createRoute(BuildContext context) {
    final Widget child = BlocProvider<OnboardingBloc>(
      create: (BuildContext context) => OnboardingBloc(
        globalAppRouter: appLocator.get<GlobalAppRouterDelegate>(),
        requestNotificationsPermissionsUseCase:
            appLocator.get<RequestNotificationsPermissionsUseCase>(),
      ),
      child: const OnboardingScreen(),
    );

    if (withSlideAnimation) {
      return CupertinoPageRoute<void>(
        builder: (_) => child,
        settings: this,
      );
    } else {
      return OpacityRoute<void>(
        builder: (_) => child,
        settings: this,
      );
    }
  }
}
