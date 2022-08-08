import 'package:flutter/material.dart';
import 'package:home/src/home_screen.dart';
import 'package:navigation/navigation.dart';

class HomeFeature {
  static const String routeName = '/home';

  static Page<dynamic> page() => HomePage();
}

class HomePage extends PageWithScaffoldKey<dynamic> {
  @override
  String get name => HomeFeature.routeName;

  @override
  Route<dynamic> createRoute(BuildContext context) {
    return MaterialPageRoute<dynamic>(
      builder: (BuildContext context) => ScaffoldMessenger(
        key: scaffoldKey,
        child: HomeScreen(
          key: AppRouter.of(context).navigationTabKey,
        ),
      ),
      settings: this,
    );
  }
}
