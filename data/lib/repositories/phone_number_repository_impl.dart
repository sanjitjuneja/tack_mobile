import 'package:data/data.dart';
import 'package:domain/models/request_sms_code_result.dart';
import 'package:domain/params_models/request_sms_params.dart';
import 'package:domain/params_models/verify_phone_number_params.dart';
import 'package:domain/repositories/phone_number_repository.dart';

class PhoneNumberRepositoryImpl implements PhoneVerificationRepository {
  final ApiProvider _apiProvider;
  final PrefsProvider _prefsProvider;

  PhoneNumberRepositoryImpl({
    required ApiProvider apiProvider,
    required PrefsProvider prefsProvider,
  })  : _apiProvider = apiProvider,
        _prefsProvider = prefsProvider;

  @override
  Future<RequestSmsCodeResult> requestSmsCode({
    required RequestSmsParams smsCodeParams,
  }) async {
    print('2');
    final RequestSmsCodeResult smsCode = await _apiProvider.requestSmsCode(
      requestSmsCodeBody: smsCodeParams.toMap(),
    );
    print('RequestSmsCodeResult');
    print(smsCode.uuid);
    return smsCode;
  }

  @override
  Future<void> verifyPhoneNumber({
    required VerifyPhoneNumberParams params,
  }) async {
    await _apiProvider.verifyPhoneNumber(
      verifyPhoneNumberBody: params.toMap(),
    );
  }
}
