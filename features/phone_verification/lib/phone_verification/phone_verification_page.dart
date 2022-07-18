import 'package:core/core.dart';
import 'package:core/di/app_di.dart';
import 'package:flutter/material.dart';
import 'package:navigation/navigation.dart';
import 'package:phone_verification/phone_verification/bloc/phone_verification_bloc.dart';
import 'package:phone_verification/phone_verification/phone_verification_screen.dart';

class PhoneVerificationPage extends PageWithScaffoldKey<String?> {
  @override
  Route<String?> createRoute(BuildContext context) {
    return MaterialPageRoute<String?>(
      settings: this,
      builder: (BuildContext context) {
        return ScaffoldMessenger(
          key: scaffoldKey,
          child: BlocProvider<PhoneVerificationBloc>(
            create: (BuildContext context) => PhoneVerificationBloc(
              appRouter: appLocator.get<AppRouterDelegate>(),
            ),
            child: const PhoneVerificationScreen(),
          ),
        );
      },
    );
  }
}
