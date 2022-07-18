import 'package:auth/sign_up/personal_information/personal_information_screen.dart';
import 'package:core/core.dart';
import 'package:core/di/app_di.dart';
import 'package:domain/usecases/sign_up_usecase.dart';
import 'package:flutter/material.dart';
import 'package:navigation/navigation.dart';

import 'bloc/personal_information_bloc.dart';

class PersonalInformationPage extends PageWithScaffoldKey<dynamic> {
  final String udid;

  PersonalInformationPage({required this.udid});

  @override
  Route<dynamic> createRoute(BuildContext context) =>
      MaterialPageRoute<dynamic>(
        builder: (BuildContext context) {
          return BlocProvider<PersonalInformationBloc>(
            create: (BuildContext context) => PersonalInformationBloc(
              signUpUseCase: appLocator.get<SignUpUseCase>(),
              appRouter: appLocator.get<AppRouterDelegate>(),
              udid: udid,
            ),
            child: ScaffoldMessenger(
              key: scaffoldKey,
              child: const PersonalInformationScreen(),
            ),
          );
        },
        settings: this,
      );
}
