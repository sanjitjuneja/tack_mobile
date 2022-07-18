import 'dart:async';

import 'package:auth/sign_up/bloc/sign_up_event.dart';
import 'package:auth/sign_up/bloc/sign_up_state.dart';
import 'package:auth/sign_up/personal_information/personal_information_page.dart';
import 'package:core/core.dart';
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

  String? udid;

  @override
  Stream<SignUpState> mapEventToState(SignUpEvent event) async* {
    if (event is VerifyPhoneNumber) {
      final String? verificationUdid = await appRouter.pushForResult(
        PhoneVerificationFeature.page(),
      );

      udid = verificationUdid;

      if (udid != null) {
        appRouter.push(
          PersonalInformationPage(
            udid: udid!,
          ),
        );
      } else {
        appRouter.popWithResult(true);
      }
    }

    if (event is RouteBack) {
      appRouter.popWithResult(true);
    }
  }
}
