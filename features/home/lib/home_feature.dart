import 'package:core/core.dart';
import 'package:core/di/app_di.dart';
import 'package:flutter/material.dart';
import 'package:home/change_group/bloc/group_bloc.dart';
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
          child: BlocProvider<GroupBloc>(
            create: (_) => GroupBloc(
              appRouter: appLocator.get<AppRouterDelegate>(),
            ),
            child: const HomeScreen(),
          ),
        ),
        settings: this,
      );
}
