import 'package:domain/repositories/auth_repository.dart';
import 'package:domain/usecases/usecase.dart';

import '../user/user.dart';

class SignUpUseCase extends FutureUseCase<void, SignUpByPhonePayload> {
  final AuthRepository _authRepository;

  SignUpUseCase({
    required AuthRepository authRepository,
  }) : _authRepository = authRepository;

  @override
  Future<Customer> execute(SignUpByPhonePayload params) async {
    return _authRepository.signUp(params: params);
  }
}
