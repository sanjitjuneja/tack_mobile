import 'dart:async';

import 'package:core/core.dart';
import 'package:domain/models/request_sms_code_result.dart';
import 'package:domain/params_models/request_sms_params.dart';
import 'package:domain/params_models/verify_phone_number_params.dart';
import 'package:domain/usecases/request_sms_code_usecase.dart';
import 'package:domain/usecases/verify_phone_number_usecase.dart';
import 'package:navigation/navigation.dart';
import 'package:phone_verification/sms_verification/bloc/sms_verification_event.dart';
import 'package:phone_verification/sms_verification/bloc/sms_verification_state.dart';

class SmsVerificationBloc
    extends Bloc<SmsVerificationEvent, SmsVerificationState> {
  final String phoneNumber;
  final AppRouterDelegate appRouter;
  final RequestSmsCodeUseCase requestSmsCodeUseCase;
  final VerifyPhoneNumberUsecase verifyPhoneNumberUsecase;

  SmsVerificationBloc({
    required this.appRouter,
    required this.phoneNumber,
    required this.requestSmsCodeUseCase,
    required this.verifyPhoneNumberUsecase,
  }) : super(SmsVerificationContent()) {
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
        final RequestSmsCodeResult result = await requestSmsCodeUseCase.execute(
          RequestSmsParams(
            phoneNumber: phoneNumber,
          ),
        );
        uuid = result.uuid;
      } on Exception catch (e) {
        print(e);
      }
    }

    if (event is VerifyNumber) {
      try {
        if (uuid != null) {
          await verifyPhoneNumberUsecase.execute(VerifyPhoneNumberParams(
            uuid: uuid!,
            smsCode: event.verificationCode,
          ));
          appRouter.popWithResult(uuid);
        }
      } on Exception catch (e) {
        print(e);
      }
    }

    if (event is RouteBack) {
      appRouter.popWithResult(uuid);
    }
  }
}
