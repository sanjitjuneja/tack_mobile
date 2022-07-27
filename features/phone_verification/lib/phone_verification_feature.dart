import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:phone_verification/phone_verification/phone_verification_page.dart';

class PhoneVerificationFeature {
  static Page<VerificationData?> page({
    required PhoneVerificationType phoneVerificationType,
  }) =>
      PhoneVerificationPage(phoneVerificationType: phoneVerificationType);
}
