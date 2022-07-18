import 'package:core/core.dart';
import 'package:core/di/app_di.dart';
import 'package:domain/usecases/request_sms_code_usecase.dart';
import 'package:domain/usecases/verify_phone_number_usecase.dart';
import 'package:flutter/material.dart';
import 'package:navigation/navigation.dart';

import 'bloc/sms_verification_bloc.dart';
import 'sms_verification_screen.dart';

class SmsVerificationPage extends PageWithScaffoldKey<String?> {
  final String phoneNumber;

  SmsVerificationPage({
    required this.phoneNumber,
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
              appRouter: appLocator.get<AppRouterDelegate>(),
              requestSmsCodeUseCase: appLocator.get<RequestSmsCodeUseCase>(),
              verifyPhoneNumberUsecase:
                  appLocator.get<VerifyPhoneNumberUsecase>(),
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
