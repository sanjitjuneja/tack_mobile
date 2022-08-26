import 'package:core/core.dart';
import 'package:domain/domain.dart';
import 'package:flutter/cupertino.dart';
import 'package:navigation/navigation.dart';

import '../../models/phone_verification_data.dart';
import '../bloc/sms_verification_bloc.dart';
import 'sms_verification_screen.dart';

class SmsVerificationFeature {
  static const String routeName = '/smsVerification';

  static Page<PhoneVerificationData?> page({
    required PhoneVerificationData phoneVerificationData,
  }) {
    return _SmsVerificationPage(
      phoneVerificationData: phoneVerificationData,
    );
  }
}

class _SmsVerificationPage extends Page<PhoneVerificationData?> {
  final PhoneVerificationData phoneVerificationData;

  const _SmsVerificationPage({
    required this.phoneVerificationData,
  });

  @override
  String get name => SmsVerificationFeature.routeName;

  @override
  Route<PhoneVerificationData?> createRoute(BuildContext context) {
    return CupertinoPageRoute<PhoneVerificationData?>(
      settings: this,
      builder: (_) {
        return BlocProvider<SmsVerificationBloc>(
          create: (BuildContext context) => SmsVerificationBloc(
            phoneVerificationData: phoneVerificationData,
            appRouter: appLocator.get<GlobalAppRouterDelegate>(),
            getRecoverySmsCodeUseCase: appLocator<GetRecoverySmsCodeUseCase>(),
            getSignUpSmsCodeUseCase: appLocator<GetSignUpSmsCodeUseCase>(),
            verifyPhoneNumberUseCase:
                appLocator.get<VerifyPhoneNumberUseCase>(),
          ),
          child: const SmsVerificationScreen(),
        );
      },
    );
  }
}
