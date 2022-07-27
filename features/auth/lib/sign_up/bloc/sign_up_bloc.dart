import 'dart:async';

import 'package:auth/sign_up/bloc/sign_up_event.dart';
import 'package:auth/sign_up/bloc/sign_up_state.dart';
import 'package:auth/sign_up/personal_information/ui/personal_information_page.dart';
import 'package:core/core.dart';
import 'package:domain/enums/phone_verification_type.dart';
import 'package:domain/models/verification_data.dart';
import 'package:navigation/navigation.dart';
import 'package:phone_verification/phone_verification_feature.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  final AppRouterDelegate appRouter;

  SignUpBloc({
    required this.appRouter,
  }) : super(SignUpContent()) {
    add(
      VerifyPhoneNumber(),
    );
  }

  VerificationData? verificationData;

  @override
  Stream<SignUpState> mapEventToState(SignUpEvent event) async* {
    if (event is VerifyPhoneNumber) {
      final VerificationData? data = await appRouter.pushForResult(
        PhoneVerificationFeature.page(
          phoneVerificationType: PhoneVerificationType.signUp,
        ),
      );

      verificationData = data;

      if (verificationData != null) {
        final bool? result = await appRouter.pushForResult(
          PersonalInformationPage(
            verificationData: verificationData!,
          ),
        );
        appRouter.popWithResult(true);
      } else {
        appRouter.popWithResult(true);
      }
    }
  }
}
