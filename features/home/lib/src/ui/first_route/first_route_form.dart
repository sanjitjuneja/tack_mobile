import 'package:core/core.dart';
import 'package:domain/domain.dart';
import 'package:flutter/cupertino.dart';
import 'package:navigation/navigation.dart';

import '../../bloc/deeplink_bloc/deeplink_bloc.dart';
import '../../bloc/global_bloc/global_bloc.dart';
import '../home/home_feature.dart';

class FirstRouteForm extends StatelessWidget {
  final AppRouterDelegate _appRouter;

  const FirstRouteForm({
    super.key,
    required AppRouterDelegate appRouter,
  }) : _appRouter = appRouter;

  @override
  Widget build(BuildContext context) {
    final BackButtonDispatcher? parentDispatcher =
        Router.of(context).backButtonDispatcher;

    final BackButtonDispatcher? childDispatcher =
        parentDispatcher?.createChildBackButtonDispatcher();
    // Tells the parent dispatcher to delegate the back button intend to this child.
    childDispatcher?.takePriority();

    return MultiBlocProvider(
      providers: <BlocProvider<dynamic>>[
        BlocProvider<DeeplinkBloc>(
          lazy: false,
          create: (_) {
            return DeeplinkBloc(
              appRouter: _appRouter,
              getLastDeeplinkUseCase: appLocator.get<GetLastDeeplinkUseCase>(),
              resetLastDeeplinkUseCase:
                  appLocator.get<ResetLastDeeplinkUseCase>(),
              observeDeeplinkUseCase: appLocator.get<ObserveDeeplinkUseCase>(),
              fetchGroupInviteUseCase:
                  appLocator.get<FetchGroupInviteUseCase>(),
            );
          },
        ),
        BlocProvider<GlobalBloc>(
          lazy: false,
          create: (_) {
            return GlobalBloc(
              appRouter: _appRouter,
              appLifeCycleProvider: appLocator.get<AppLifeCycleProvider>(),
              getCurrentUserUseCase: appLocator.get<GetCurrentUserUseCase>(),
              observeUserUseCase: appLocator.get<ObserveUserUseCase>(),
              getCurrentGroupUseCase: appLocator.get<GetCurrentGroupUseCase>(),
              getGroupsCountUseCase: appLocator.get<GetGroupsCountUseCase>(),
              observeCurrentGroupUseCase:
                  appLocator.get<ObserveCurrentGroupUseCase>(),
              observeGroupsCountUseCase:
                  appLocator.get<ObserveGroupsCountUseCase>(),
              observeCompletedTackRunnerIntentUseCase:
                  appLocator.get<ObserveCompletedTackRunnerIntentUseCase>(),
              observeCancelTackerTackRunnerIntentUseCase:
                  appLocator.get<ObserveCancelTackerTackRunnerIntentUseCase>(),
              observeRunnerTackIntentUseCase:
                  appLocator.get<ObserveRunnerTackIntentUseCase>(),
              observeTackerTackIntentUseCase:
                  appLocator.get<ObserveTackerTackIntentUseCase>(),
              fetchUserUseCase: appLocator.get<FetchUserUseCase>(),
              fetchUserBalanceUseCase:
                  appLocator.get<FetchUserBalanceUseCase>(),
              fetchGroupUseCase: appLocator.get<FetchGroupUseCase>(),
              selectGroupUseCase: appLocator.get<SelectGroupUseCase>(),
            );
          },
        ),
      ],
      child: Router(
        backButtonDispatcher: childDispatcher,
        routeInformationProvider: PlatformRouteInformationProvider(
          initialRouteInformation: const RouteInformation(
            location: HomeFeature.routeName,
          ),
        ),
        routeInformationParser: appLocator.get<AppRouteInformationParser>(),
        routerDelegate: _appRouter,
      ),
    );
  }
}
