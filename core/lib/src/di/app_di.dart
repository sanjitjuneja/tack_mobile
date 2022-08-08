import 'package:get_it/get_it.dart';
import 'package:navigation/navigation.dart';

final AppDI appDI = AppDI();
final GetIt appLocator = GetIt.instance;

class AppDI {
  void initDependencies() {
    final PopNavigationObserver globalPopNavigationObserver = PopNavigationObserver();

    final AppMessageNotifier globalAppMessageNotifier = AppMessageNotifier();

    final GlobalAppRouterDelegate globalAppRouter = GlobalAppRouterDelegate(
      messageNotifier: globalAppMessageNotifier,
      popNavigationObserver: globalPopNavigationObserver,
    );

    globalAppMessageNotifier.appRouter = globalAppRouter;

    appLocator.registerSingleton<GlobalAppRouterDelegate>(globalAppRouter);

    final PopNavigationObserver popNavigationObserver = PopNavigationObserver();
    final AppMessageNotifier appMessageNotifier = AppMessageNotifier();

    final AppRouterDelegate appRouter = AppRouterDelegate(
      messageNotifier: appMessageNotifier,
      popNavigationObserver: popNavigationObserver,
    );

    appLocator.registerSingleton<AppRouterDelegate>(appRouter);

    appMessageNotifier.appRouter = appRouter;

    appLocator.registerSingleton<AppRouteInformationParser>(
      AppRouteInformationParser(),
    );
  }
}
