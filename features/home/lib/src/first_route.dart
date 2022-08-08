import 'package:core/core.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:home/home.dart';
import 'package:navigation/navigation.dart';

class FirstRouteFeature {
  static const String routeName = '/firstRoute';

  static Page<void> page() => FirstRoutePage();
}

class FirstRoutePage extends Page<void> {
  final AppRouterDelegate _appRouter;

  @override
  String get name => FirstRouteFeature.routeName;

  FirstRoutePage() : _appRouter = appLocator.get<AppRouterDelegate>();

  @override
  Route<void> createRoute(BuildContext context) {
    return MaterialPageRoute<dynamic>(
      builder: (BuildContext context) {
        return MultiBlocProvider(
          providers: <BlocProvider<dynamic>>[
            BlocProvider<GlobalBloc>(
              create: (_) => GlobalBloc(
                appRouter: _appRouter,
                getCurrentUserUseCase: appLocator.get<GetCurrentUserUseCase>(),
                observeUserUseCase: appLocator.get<ObserveUserUseCase>(),
                getCurrentGroupUseCase:
                    appLocator.get<GetCurrentGroupUseCase>(),
                getGroupsUseCase: appLocator.get<GetGroupsUseCase>(),
                observeCurrentGroupUseCase:
                    appLocator.get<ObserveCurrentGroupUseCase>(),
                observeGroupsUseCase: appLocator.get<ObserveGroupsUseCase>(),
                selectGroupUseCase: appLocator.get<SelectGroupUseCase>(),
              ),
            ),
          ],
          child: Router(
            routeInformationProvider: PlatformRouteInformationProvider(
              initialRouteInformation:
                  const RouteInformation(location: HomeFeature.routeName),
            ),
            routeInformationParser: appLocator.get<AppRouteInformationParser>(),
            routerDelegate: _appRouter,
          ),
        );
      },
      settings: this,
    );
  }
}
