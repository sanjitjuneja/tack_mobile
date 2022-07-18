import 'package:core/core.dart';
import 'package:core/di/app_di.dart';
import 'package:flutter/material.dart';
import 'package:navigation/navigation.dart';
import 'package:splash/splash_screen.dart';

import 'bloc/splash_bloc.dart';

class SplashFeature {
  static Page<dynamic> page() => SplashPage();
}

class SplashPage extends PageWithScaffoldKey<dynamic> {
  @override
  Route<dynamic> createRoute(BuildContext context) =>
      MaterialPageRoute<dynamic>(
        builder: (BuildContext context) {
          return BlocProvider<SplashBloc>(
            create: (BuildContext context) => SplashBloc(
              appRouter: appLocator.get<AppRouterDelegate>(),
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