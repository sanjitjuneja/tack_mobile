import 'package:auth/sign_in/sign_in_screen.dart';
import 'package:core/core.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:navigation/navigation.dart';

import 'bloc/sign_in_bloc.dart';

class SignInFeature {
  static Page<bool> page() => SignInPage();
}

class SignInPage extends PageWithScaffoldKey<bool> {
  @override
  Route<bool> createRoute(BuildContext context) => PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 200),
        pageBuilder: (BuildContext context, animation, secondaryAnimation) {
          return BlocProvider<SignInBloc>(
            create: (BuildContext context) {
              return SignInBloc(
                appRouter: appLocator.get<GlobalAppRouterDelegate>(),
                signInUseCase: appLocator.get<SignInUseCase>(),
              );
            },
            child: ScaffoldMessenger(
              key: scaffoldKey,
              child: const SignInScreen(),
            ),
          );
        },
        transitionsBuilder:
            (context, primaryAnimation, secondaryAnimation, child) {
          return FadeTransition(
            opacity: primaryAnimation,
            child: child,
          );
        },
        settings: this,
      );
}
