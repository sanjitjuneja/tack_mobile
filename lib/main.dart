import 'package:core/di/app_di.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'app/tack_app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  //Disable portrait mode
  await SystemChrome.setPreferredOrientations(
    <DeviceOrientation>[
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ],
  );

  appDI.initDependencies();

  runApp(
    const TackApp(),
  );
}
