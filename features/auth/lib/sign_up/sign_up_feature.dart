import 'package:auth/sign_up/sign_up_screen.dart';
import 'package:core/core.dart';
import 'package:core/di/app_di.dart';
import 'package:flutter/material.dart';
import 'package:navigation/navigation.dart';

import 'bloc/sign_up_bloc.dart';

class SignUpFeature {
  static Page<bool> page() => SignInPage();
}

class SignInPage extends PageWithScaffoldKey<bool> {
  @override
  Route<bool> createRoute(BuildContext context) => PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 200),
        pageBuilder: (BuildContext context, animation, secondaryAnimation) {
          return BlocProvider<SignUpBloc>(
            create: (BuildContext context) {
              return SignUpBloc(
                appRouter: appLocator.get<AppRouterDelegate>(),
              );
            },
            child: ScaffoldMessenger(
              key: scaffoldKey,
              child: const SignUpScreen(),
            ),
          );
        },
        transitionsBuilder: (context, animation1, animation2, child) {
          return FadeTransition(
            opacity: animation1,
            child: child,
          );
        },
        settings: this,
      );
}
