import 'package:core/core.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:navigation/navigation.dart';
import 'package:phone_verification/phone_verification/bloc/phone_verification_bloc.dart';
import 'package:phone_verification/phone_verification/phone_verification_screen.dart';

class PhoneVerificationPage extends PageWithScaffoldKey<VerificationData?> {
  final PhoneVerificationType phoneVerificationType;

  PhoneVerificationPage({
    required this.phoneVerificationType,
  });

  @override
  Route<VerificationData?> createRoute(BuildContext context) {
    return MaterialPageRoute<VerificationData?>(
      settings: this,
      builder: (BuildContext context) {
        return ScaffoldMessenger(
          key: scaffoldKey,
          child: BlocProvider<PhoneVerificationBloc>(
            create: (BuildContext context) => PhoneVerificationBloc(
              phoneVerificationType: phoneVerificationType,
              appRouter: appLocator.get<AppRouterDelegate>(),
            ),
            child: PhoneVerificationScreen(
              phoneVerificationType: phoneVerificationType,
            ),
          ),
        );
      },
    );
  }
}
