import 'package:flutter/material.dart';
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
          child: const HomeScreen(),
        ),
        settings: this,
      );
}
