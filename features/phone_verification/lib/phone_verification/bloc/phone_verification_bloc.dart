import 'dart:async';

import 'package:core/core.dart';
import 'package:domain/domain.dart';
import 'package:navigation/navigation.dart';
import 'package:phone_verification/phone_verification/bloc/phone_verification_event.dart';
import 'package:phone_verification/phone_verification/bloc/phone_verification_state.dart';
import 'package:phone_verification/sms_verification/sms_verification_page.dart';

class PhoneVerificationBloc
    extends Bloc<PhoneVerificationEvent, PhoneVerificationState> {
  final AppRouterDelegate appRouter;
  final PhoneVerificationType phoneVerificationType;

  PhoneVerificationBloc({
    required this.appRouter,
    required this.phoneVerificationType,
  }) : super(
          PhoneVerificationContent(isDataValid: false),
        );

  String? udid;

  @override
  Stream<PhoneVerificationState> mapEventToState(
      PhoneVerificationEvent event) async* {
    if (event is VerifyPhoneNumber) {
      final String phoneNumber =
          PhoneNumberFormatter.getPhoneWithoutSpaces(event.phoneNumber);
      final formattedNumber = '${Constants.kPhonePrefix}$phoneNumber';
      udid = await appRouter.pushForResult(
        SmsVerificationPage(
          phoneNumber: formattedNumber,
          phoneVerificationType: phoneVerificationType,
        ),
      );

      if (udid != null) {
        appRouter.popWithResult(
          VerificationData(
            udid: udid!,
            phoneNumber: formattedNumber,
          ),
        );
      }
    }

    if (event is UpdateData) {
      final bool isDataValid = _validateData(
        phoneNumber: event.phoneNumber,
      );

      yield PhoneVerificationContent(
        isDataValid: isDataValid,
      );
    }
  }

  bool _validateData({
    required String phoneNumber,
  }) {
    final bool isPhoneValid = FieldValidator.validatePhoneNumber(phoneNumber);
    return isPhoneValid;
  }
}
