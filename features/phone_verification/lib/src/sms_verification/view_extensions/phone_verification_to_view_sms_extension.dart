import 'package:core/core.dart';
import 'package:flutter/cupertino.dart';

import '../../models/phone_verification_data.dart';
import '../../models/phone_verification_type.dart';

extension PhoneVerificationToViewSmsExtension on PhoneVerificationData {
  String getTitle(BuildContext context) {
    return FlutterI18n.translate(
      context,
      'smsVerificationScreen.$typeKey.title',
    );
  }

  String getDescription(BuildContext context) {
    return FlutterI18n.translate(
      context,
      'smsVerificationScreen.$typeKey.description',
      translationParams: <String, String>{
        'phoneNumber': phoneNumber,
      },
    );
  }

  String getButtonLabel(BuildContext context) {
    return FlutterI18n.translate(
      context,
      'smsVerificationScreen.$typeKey.buttonLabel',
    );
  }

  String get typeKey {
    switch (verificationType) {
      case PhoneVerificationType.signUp:
        return 'signUp';
      case PhoneVerificationType.forgotPassword:
        return 'recovery';
    }
  }
}
