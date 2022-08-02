import 'package:auth/sign_up/personal_information/ui/personal_information_screen.dart';
import 'package:core/core.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:navigation/navigation.dart';

import '../bloc/personal_information_bloc.dart';

class PersonalInformationPage extends PageWithScaffoldKey<bool?> {
  final VerificationData verificationData;

  PersonalInformationPage({
    required this.verificationData,
  });

  @override
  Route<bool?> createRoute(BuildContext context) => MaterialPageRoute<bool?>(
        builder: (BuildContext context) {
          return BlocProvider<PersonalInformationBloc>(
            create: (BuildContext context) => PersonalInformationBloc(
              verificationData: verificationData,
              signUpUseCase: appLocator.get<SignUpUseCase>(),
              appRouter: appLocator.get<AppRouterDelegate>(),
            ),
            child: ScaffoldMessenger(
              key: scaffoldKey,
              child: PersonalInformationScreen(
                phoneNumber: verificationData.phoneNumber,
              ),
            ),
          );
        },
        settings: this,
      );
}
