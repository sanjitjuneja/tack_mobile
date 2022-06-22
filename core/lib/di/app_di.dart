import 'package:get_it/get_it.dart';
import 'package:navigation/navigation.dart';

final AppDI appDI = AppDI();
final GetIt appLocator = GetIt.instance;

class AppDI {
  void initDependencies() {
    final AppMessageNotifier appMessageNotifier = AppMessageNotifier();
    final PopNavigationObserver popNavigationObserver = PopNavigationObserver();

    final AppRouter appRouter = AppRouter(
      messageNotifier: appMessageNotifier,
      popNavigationObserver: popNavigationObserver,
    );

    appMessageNotifier.appRouter = appRouter;
    popNavigationObserver.appRouter = appRouter;

    appLocator.registerSingleton<AppRouter>(appRouter);

    appLocator.registerSingleton<AppRouteInformationParser>(
      AppRouteInformationParser(),
    );
  }
}
