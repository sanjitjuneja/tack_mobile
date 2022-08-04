import 'package:core/core.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:navigation/navigation.dart';
import 'package:splash/splash_screen.dart';

import 'bloc/splash_bloc.dart';

class SplashFeature {
  static const String routeName = '/splash';

  static Page<dynamic> page() => SplashPage();
}

class SplashPage extends PageWithScaffoldKey<dynamic> {
  @override
  String get name => SplashFeature.routeName;

  @override
  Route<dynamic> createRoute(BuildContext context) {
    return MaterialPageRoute<dynamic>(
      builder: (BuildContext context) {
        return BlocProvider<SplashBloc>(
          create: (BuildContext context) => SplashBloc(
            globalAppRouter: appLocator.get<GlobalAppRouterDelegate>(),
            isAuthorizedUseCase: appLocator.get<IsAuthorizedUseCase>(),
          ),
          child: ScaffoldMessenger(
            key: scaffoldKey,
            child: const SplashScreen(),
          ),
        );
      },
      settings: this,
    );
  }
}
