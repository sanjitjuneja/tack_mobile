import 'package:core/core.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:navigation/navigation.dart';

import 'bloc/sms_verification_bloc.dart';
import 'sms_verification_screen.dart';

class SmsVerificationPage extends PageWithScaffoldKey<String?> {
  final String phoneNumber;
  final PhoneVerificationType phoneVerificationType;

  SmsVerificationPage({
    required this.phoneNumber,
    required this.phoneVerificationType,
  });

  @override
  Route<String?> createRoute(BuildContext context) {
    return MaterialPageRoute<String?>(
      settings: this,
      builder: (BuildContext context) {
        return ScaffoldMessenger(
          key: scaffoldKey,
          child: BlocProvider<SmsVerificationBloc>(
            create: (BuildContext context) => SmsVerificationBloc(
              phoneNumber: phoneNumber,
              phoneVerificationType: phoneVerificationType,
              appRouter: appLocator.get<AppRouterDelegate>(),
              requestSmsCodeUseCase: appLocator.get<RequestSmsCodeUseCase>(),
              verifyPhoneNumberUseCase:
                  appLocator.get<VerifyPhoneNumberUseCase>(),
            ),
            child: NumberVerifyScreen(
              phoneNumber: phoneNumber,
            ),
          ),
        );
      },
    );
  }
}
