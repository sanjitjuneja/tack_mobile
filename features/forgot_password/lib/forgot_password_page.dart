import 'package:core/core.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:navigation/navigation.dart';

import 'bloc/forgot_password_bloc.dart';
import 'forgot_password_screen.dart';

class ForgotPasswordPage extends PageWithScaffoldKey<dynamic> {
  final PhoneVerificationType phoneVerificationType;

  ForgotPasswordPage({
    required this.phoneVerificationType,
  });

  @override
  Route<dynamic> createRoute(BuildContext context) =>
      MaterialPageRoute<dynamic>(
        builder: (BuildContext context) {
          return ScaffoldMessenger(
            key: scaffoldKey,
            child: BlocProvider<ForgotPasswordBloc>(
              create: (BuildContext context) => ForgotPasswordBloc(
                phoneVerificationType: phoneVerificationType,
                appRouter: appLocator.get<GlobalAppRouterDelegate>(),
              ),
              child: const ForgotPasswordScreen(),
            ),
          );
        },
        settings: this,
      );
}
