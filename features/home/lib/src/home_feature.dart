import 'package:core/core.dart';
import 'package:core/di/app_di.dart';
import 'package:dashboard/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:home/home.dart';
import 'package:navigation/navigation.dart';

import 'home_screen.dart';

class HomeFeature {
  static Page<dynamic> page() => HomePage();
}

class HomePage extends PageWithScaffoldKey<dynamic> {
  @override
  Route<dynamic> createRoute(BuildContext context) =>
      MaterialPageRoute<dynamic>(
        builder: (BuildContext context) => ScaffoldMessenger(
          key: scaffoldKey,
          child: MultiBlocProvider(
            providers: <BlocProvider<dynamic>>[
              BlocProvider<GlobalBloc>(
                create: (_) => GlobalBloc(
                  appRouter: appLocator.get<AppRouterDelegate>(),
                  groups: getGroups(3),
                ),
              ),
            ],
            child: HomeScreen(
              key: AppRouter.of(context).navigationTabKey,
            ),
          ),
        ),
        settings: this,
      );
}
