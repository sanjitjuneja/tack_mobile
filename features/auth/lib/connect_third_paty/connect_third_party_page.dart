import 'package:flutter/material.dart';
import 'package:navigation/navigation.dart';

import 'connect_third_party_screen.dart';

class ConnectThirdPartyPage extends PageWithScaffoldKey<dynamic> {
  @override
  Route<dynamic> createRoute(BuildContext context) =>
      MaterialPageRoute<dynamic>(
        builder: (BuildContext context) {
          return ScaffoldMessenger(
            key: scaffoldKey,
            child: const ConnectThirdPartyScreen(),
          );
        },
        settings: this,
      );
}