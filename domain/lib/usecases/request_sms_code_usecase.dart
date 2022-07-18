import 'package:domain/models/request_sms_code_result.dart';
import 'package:domain/params_models/request_sms_params.dart';
import 'package:domain/usecases/usecase.dart';

import '../repositories/phone_number_repository.dart';

class RequestSmsCodeUseCase extends FutureUseCase<void, RequestSmsParams> {
  final PhoneVerificationRepository _phoneNumberRepository;

  RequestSmsCodeUseCase({
    required PhoneVerificationRepository phoneNumberRepository,
  }) : _phoneNumberRepository = phoneNumberRepository;

  @override
  Future<RequestSmsCodeResult> execute(RequestSmsParams params) async {
    final k = _phoneNumberRepository.requestSmsCode(smsCodeParams: params);
    return k;
  }
}
