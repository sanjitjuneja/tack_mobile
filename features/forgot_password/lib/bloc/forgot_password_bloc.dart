import 'dart:async';

import 'package:core/core.dart';
import 'package:navigation/navigation.dart';
import 'package:phone_verification/phone_verification_feature.dart';

import 'forgot_password_event.dart';
import 'forgot_password_state.dart';

class ForgotPasswordBloc
    extends Bloc<ForgotPasswordEvent, ForgotPasswordState> {
  final AppRouterDelegate appRouter;

  ForgotPasswordBloc({
    required this.appRouter,
  }) : super(ForgotPasswordContent()) {
    add(
      GetVerificationCode(),
    );
  }

  @override
  Stream<ForgotPasswordState> mapEventToState(
      ForgotPasswordEvent event) async* {
    if (event is GetVerificationCode) {
      final bool result = await appRouter.pushForResult(
        PhoneVerificationFeature.page(),
      );
    }
  }
}
