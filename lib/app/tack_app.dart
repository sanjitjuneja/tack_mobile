import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:navigation/navigation.dart';

class TackApp extends StatefulWidget {
  const TackApp({
    Key? key,
  }) : super(key: key);

  @override
  State<TackApp> createState() => _TackAppState();
}

class _TackAppState extends State<TackApp> {
  late final GlobalAppRouterDelegate globalAppRouter;
  late final RouteInformationParser<RouteConfiguration> routeInformationParser;

  @override
  void initState() {
    globalAppRouter = appLocator.get<GlobalAppRouterDelegate>();
    routeInformationParser = appLocator.get<AppRouteInformationParser>();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TimeTickerInheritedWidget(
      child: CupertinoApp.router(
        debugShowCheckedModeBanner: false,
        localizationsDelegates: <LocalizationsDelegate<dynamic>>[
          FlutterI18nDelegate(
            translationLoader: FileTranslationLoader(
              useCountryCode: false,
              basePath: 'localization',
              fallbackFile: 'en',
              decodeStrategies: <BaseDecodeStrategy>[
                JsonDecodeStrategy(),
              ],
            ),
          ),
          GlobalMaterialLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate
        ],
        routerDelegate: globalAppRouter,
        routeInformationParser: routeInformationParser,
      ),
    );
  }
}
