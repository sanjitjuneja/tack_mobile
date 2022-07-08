import 'package:core/di/app_di.dart';
import 'package:core/di/data_di.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'app/app_config.dart';
import 'app/tack_app.dart';

Future<void> mainCommon(Flavor flavor) async {
  WidgetsFlutterBinding.ensureInitialized();

  //Disable portrait mode
  await SystemChrome.setPreferredOrientations(
    <DeviceOrientation>[
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ],
  );

  appDI.initDependencies();
  await dataDI.initDependencies(
    baseUrl: AppConfig.fromFlavor(flavor).baseUrl,
  );

  runApp(
    const TackApp(),
  );
}
