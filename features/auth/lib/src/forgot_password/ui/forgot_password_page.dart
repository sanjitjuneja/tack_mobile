import 'package:core/core.dart';
import 'package:domain/domain.dart';
import 'package:flutter/cupertino.dart';
import 'package:navigation/navigation.dart';
import 'package:phone_verification/phone_verification.dart';

import '../bloc/forgot_password_bloc.dart';
import 'forgot_password_screen.dart';

class ForgotPasswordFeature {
  static const String routeName = '/forgotPassword';

  static Page<bool?> page({
    required PhoneVerificationData phoneVerificationData,
  }) {
    return _ForgotPasswordPage(
      phoneVerificationData: phoneVerificationData,
    );
  }
}

class _ForgotPasswordPage extends Page<bool?> {
  final PhoneVerificationData phoneVerificationData;

  const _ForgotPasswordPage({
    required this.phoneVerificationData,
  });

  @override
  String get name => ForgotPasswordFeature.routeName;

  @override
  Route<bool?> createRoute(BuildContext context) {
    return CupertinoPageRoute<bool?>(
      settings: this,
      builder: (_) {
        return BlocProvider<ForgotPasswordBloc>(
          create: (_) {
            return ForgotPasswordBloc(
              phoneVerificationData: phoneVerificationData,
              appRouter: GlobalAppRouter.of(context),
              changePasswordRecoveryUseCase:
                  appLocator.get<ChangePasswordRecoveryUseCase>(),
            );
          },
          child: const ForgotPasswordScreen(),
        );
      },
    );
  }
}
