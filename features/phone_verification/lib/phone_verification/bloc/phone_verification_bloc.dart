import 'dart:async';

import 'package:core/core.dart';
import 'package:navigation/navigation.dart';
import 'package:phone_verification/phone_verification/bloc/phone_verification_event.dart';
import 'package:phone_verification/phone_verification/bloc/phone_verification_state.dart';
import 'package:phone_verification/sms_verification/sms_verification_page.dart';

class PhoneVerificationBloc
    extends Bloc<PhoneVerificationEvent, PhoneVerificationState> {
  final AppRouterDelegate appRouter;

  PhoneVerificationBloc({
    required this.appRouter,
  }) : super(
          PhoneVerificationContent(isDataValid: false),
        );

  String? udid;

  @override
  Stream<PhoneVerificationState> mapEventToState(
      PhoneVerificationEvent event) async* {
    if (event is VerifyPhoneNumber) {
      final formattedNumber =
          '${Constants.kPhonePrefix}${event.phoneNumber.replaceAll(RegExp(r"\s+"), "")}';
      udid = await appRouter.pushForResult(
        // SmsVerificationPage(phoneNumber: formattedNumber),
        SmsVerificationPage(phoneNumber: '+375295685885'),
      );

      appRouter.popWithResult(udid);
    }

    if (event is UpdateData) {
      final bool isDataValid = _validateData(
        phoneNumber: event.phoneNumber,
      );

      yield PhoneVerificationContent(
        isDataValid: isDataValid,
      );
    }

    if (event is RouteBack) {
      appRouter.popWithResult(null);
    }
  }

  bool _validateData({required String phoneNumber}) {
    final bool isPhoneValid = FieldValidator.validatePhoneNumber(phoneNumber);
    return isPhoneValid;
  }
}
