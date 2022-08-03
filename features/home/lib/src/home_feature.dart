import 'package:core/core.dart';
import 'package:dashboard/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:home/src/global_bloc/global_bloc.dart';
import 'package:home/src/home_screen.dart';
import 'package:navigation/navigation.dart';

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
                  groups: getGroups(10),
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
