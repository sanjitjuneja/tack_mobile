import 'package:flutter/material.dart';
import 'package:navigation/navigation.dart';

import 'error_screen.dart';

class ErrorPage extends PageWithScaffoldKey<void> {
  final String titleKey;
  final Function onPressed;
  final String descriptionKey;

  ErrorPage({
    required this.titleKey,
    required this.onPressed,
    required this.descriptionKey,
  });

  @override
  Route<void> createRoute(BuildContext context) => MaterialPageRoute<void>(
        builder: (BuildContext context) {
          return ScaffoldMessenger(
            key: scaffoldKey,
            child: ErrorScreen(
              titleKey: titleKey,
              onPressed: onPressed,
              descriptionKey: descriptionKey,
            ),
          );
        },
        settings: this,
      );
}
