import 'package:core/core.dart';
import 'package:domain/domain.dart';
import 'package:flutter/cupertino.dart';
import 'package:navigation/navigation.dart';
import 'package:splash/src/ui/splash_screen.dart';

import '../bloc/splash_bloc.dart';

class SplashFeature {
  static const String routeName = '/splash';

  static Page<void> page() => _SplashPage();
}

class _SplashPage extends Page<void> {
  @override
  String get name => SplashFeature.routeName;

  @override
  Route<void> createRoute(BuildContext context) {
    return CupertinoPageRoute<void>(
      settings: this,
      builder: (_) {
        return BlocProvider<SplashBloc>(
          lazy: false,
          create: (_) => SplashBloc(
            globalAppRouter: appLocator.get<GlobalAppRouterDelegate>(),
            isAuthorizedUseCase: appLocator.get<IsAuthorizedUseCase>(),
          ),
          child: const SplashScreen(),
        );
      },
    );
  }
}
