import 'package:domain/params_models/verify_phone_number_params.dart';

import '../models/request_sms_code_result.dart';
import '../params_models/request_sms_params.dart';

abstract class PhoneVerificationRepository {
  Future<RequestSmsCodeResult> requestSmsCode({
    required RequestSmsParams smsCodeParams,
  });

  Future<void> verifyPhoneNumber({
    required VerifyPhoneNumberParams params,
  });
}
