import 'package:core/core.dart';
import 'package:core/di/app_di.dart';
import 'package:flutter/material.dart';
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
  late final AppRouter appRouter;
  late final RouteInformationParser<RouteConfiguration> routeInformationParser;

  @override
  void initState() {
    appRouter = appLocator.get<AppRouter>();
    routeInformationParser = appLocator.get<AppRouteInformationParser>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      localizationsDelegates: const <LocalizationsDelegate<dynamic>>[
        AppLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate
      ],
      supportedLocales: AppLocalizations.supportedLocales,
      localeResolutionCallback:
          (Locale? deviceLocale, Iterable<Locale> supportedLocales) {
        return AppLocalizations.resolveLocale(
          deviceLocale!,
          supportedLocales,
        );
      },
      routeInformationParser: routeInformationParser,
      routerDelegate: appRouter,
    );
  }
}
