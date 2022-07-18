import 'package:domain/params_models/verify_phone_number_params.dart';
import 'package:domain/usecases/usecase.dart';

import '../repositories/phone_number_repository.dart';

class VerifyPhoneNumberUsecase
    extends FutureUseCase<void, VerifyPhoneNumberParams> {
  final PhoneVerificationRepository _phoneNumberRepository;

  VerifyPhoneNumberUsecase({
    required PhoneVerificationRepository phoneNumberRepository,
  }) : _phoneNumberRepository = phoneNumberRepository;

  @override
  Future<void> execute(VerifyPhoneNumberParams params) async {
    _phoneNumberRepository.verifyPhoneNumber(params: params);
  }
}
