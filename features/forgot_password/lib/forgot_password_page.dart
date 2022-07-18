import 'package:core/core.dart';
import 'package:core/di/app_di.dart';
import 'package:flutter/material.dart';
import 'package:navigation/navigation.dart';

import 'bloc/forgot_password_bloc.dart';
import 'forgot_password_screen.dart';

class ForgotPasswordPage extends PageWithScaffoldKey<dynamic> {
  @override
  Route<dynamic> createRoute(BuildContext context) =>
      MaterialPageRoute<dynamic>(
        builder: (BuildContext context) {
          return ScaffoldMessenger(
            key: scaffoldKey,
            child: BlocProvider<ForgotPasswordBloc>(
              create: (BuildContext context) => ForgotPasswordBloc(
                appRouter: appLocator.get<AppRouterDelegate>(),
              ),
              child: const ForgotPasswordScreen(),
            ),
          );
        },
        settings: this,
      );
}
