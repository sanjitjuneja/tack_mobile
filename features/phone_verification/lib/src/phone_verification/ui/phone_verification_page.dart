import 'package:core/core.dart';
import 'package:domain/domain.dart';
import 'package:flutter/cupertino.dart';
import 'package:navigation/navigation.dart';

import '../../models/phone_verification_screen_result.dart';
import '../../models/phone_verification_type.dart';
import '../bloc/phone_verification_bloc.dart';
import 'phone_verification_screen.dart';

class PhoneVerificationFeature {
  static const String routeName = '/phoneVerification';

  static Page<PhoneVerificationScreenResult?> pageForSignUp() {
    return const _PhoneVerificationPage(
      verificationType: PhoneVerificationType.signUp,
    );
  }

  static Page<PhoneVerificationScreenResult?> pageForForgotPassword() {
    return const _PhoneVerificationPage(
      verificationType: PhoneVerificationType.forgotPassword,
    );
  }
}

class _PhoneVerificationPage extends Page<PhoneVerificationScreenResult?> {
  final PhoneVerificationType verificationType;

  const _PhoneVerificationPage({
    required this.verificationType,
  });

  @override
  String get name => PhoneVerificationFeature.routeName;

  @override
  Route<PhoneVerificationScreenResult?> createRoute(BuildContext context) {
    return CupertinoPageRoute<PhoneVerificationScreenResult?>(
      settings: this,
      builder: (_) {
        return BlocProvider<PhoneVerificationBloc>(
          create: (_) {
            return PhoneVerificationBloc(
              phoneVerificationType: verificationType,
              appRouter: GlobalAppRouter.of(context),
              getRecoverySmsCodeUseCase:
                  appLocator<GetRecoverySmsCodeUseCase>(),
              getSignUpSmsCodeUseCase: appLocator<GetSignUpSmsCodeUseCase>(),
            );
          },
          child: const PhoneVerificationScreen(),
        );
      },
    );
  }
}
