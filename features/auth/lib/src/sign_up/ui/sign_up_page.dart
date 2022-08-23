import 'package:core/core.dart';
import 'package:domain/domain.dart';
import 'package:flutter/cupertino.dart';
import 'package:navigation/navigation.dart';
import 'package:phone_verification/phone_verification.dart';

import '../bloc/sign_up_bloc.dart';
import 'sign_up_screen.dart';

class SignUpFeature {
  static const String routeName = '/signUp';

  static Page<void> page({
    required PhoneVerificationData phoneVerificationData,
  }) {
    return _SignUpPage(
      phoneVerificationData: phoneVerificationData,
    );
  }
}

class _SignUpPage extends Page<void> {
  final PhoneVerificationData phoneVerificationData;

  const _SignUpPage({
    required this.phoneVerificationData,
  });

  @override
  String get name => SignUpFeature.routeName;

  @override
  Route<void> createRoute(BuildContext context) {
    return CupertinoPageRoute<void>(
      settings: this,
      builder: (_) {
        return BlocProvider<SignUpBloc>(
          create: (BuildContext context) => SignUpBloc(
            phoneVerificationData: phoneVerificationData,
            signUpUseCase: appLocator.get<SignUpUseCase>(),
            appRouter: appLocator.get<GlobalAppRouterDelegate>(),
          ),
          child: const SignUpScreen(),
        );
      },
    );
  }
}
