import 'dart:async';

import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:domain/domain.dart';
import 'package:navigation/navigation.dart';
import 'package:phone_verification/sms_verification/bloc/sms_verification_event.dart';
import 'package:phone_verification/sms_verification/bloc/sms_verification_state.dart';

class SmsVerificationBloc
    extends Bloc<SmsVerificationEvent, SmsVerificationState> {
  final String phoneNumber;
  final AppRouterDelegate appRouter;
  final PhoneVerificationType phoneVerificationType;
  final RequestSmsCodeUseCase requestSmsCodeUseCase;
  final VerifyPhoneNumberUseCase verifyPhoneNumberUseCase;

  SmsVerificationBloc({
    required this.appRouter,
    required this.phoneNumber,
    required this.phoneVerificationType,
    required this.requestSmsCodeUseCase,
    required this.verifyPhoneNumberUseCase,
  }) : super(SmsVerificationContent(isDataValid: false)) {
    add(
      RequestVerificationCode(),
    );
  }

  String? uuid;

  @override
  Stream<SmsVerificationState> mapEventToState(
      SmsVerificationEvent event) async* {
    if (event is RequestVerificationCode) {
      try {
        final SmsCodeResult result = await requestSmsCodeUseCase.execute(
          RequestSmsCodePayload(
            phoneNumber: phoneNumber,
            phoneVerificationType: phoneVerificationType,
          ),
        );
        uuid = result.uuid;
      } on Exception catch (e) {
        e.toString();
      }
    }

    if (event is VerifyNumber) {
      try {
        if (uuid != null) {
          appRouter.push(ProgressDialog.page());
          final PhoneVerificationResult result =
              await verifyPhoneNumberUseCase.execute(VerifyPhoneNumberPayload(
            uuid: uuid!,
            smsCode: event.verificationCode,
          ));
          appRouter.pop();
          appRouter.popWithResult(uuid);
        }
      } catch (e) {
        appRouter.push(
          AppAlertDialog.page(
            ErrorAlert(
              contentKey: 'signUp.buttonSignUp',
              messageKey: e.toString(),
            ),
          ),
        );
      }
    }

    if (event is UpdateData) {
      final bool result = isCodeValid(event.verificationCode);

      yield SmsVerificationContent(isDataValid: result);
    }

    if (event is RouteBack) {
      appRouter.popWithResult(uuid);
    }
  }
}

bool isCodeValid(String verificationCode) {
  if (verificationCode.length == 6) {
    return true;
  } else {
    return false;
  }
}
