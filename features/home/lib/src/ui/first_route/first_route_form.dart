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
          create: (_) {
            return GlobalBloc(
              appRouter: _appRouter,
              getCurrentUserUseCase: appLocator.get<GetCurrentUserUseCase>(),
              observeUserUseCase: appLocator.get<ObserveUserUseCase>(),
              getCurrentGroupUseCase: appLocator.get<GetCurrentGroupUseCase>(),
              getGroupsCountUseCase: appLocator.get<GetGroupsCountUseCase>(),
              observeCurrentGroupUseCase:
                  appLocator.get<ObserveCurrentGroupUseCase>(),
              observeGroupsCountUseCase:
                  appLocator.get<ObserveGroupsCountUseCase>(),
              fetchGroupUseCase: appLocator.get<FetchGroupUseCase>(),
              selectGroupUseCase: appLocator.get<SelectGroupUseCase>(),
            );
          },
        ),
      ],
      child: Router(
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
