import 'package:domain/repositories/auth_repository.dart';
import 'package:domain/usecases/usecase.dart';

import '../auth/phone_verification.dart';

class SignInUseCase extends FutureUseCase<void, SignInPayload> {
  final AuthRepository _authRepository;

  SignInUseCase({
    required AuthRepository authRepository,
  }) : _authRepository = authRepository;

  @override
  Future<Message> execute(SignInPayload params) async {
    return _authRepository.signIn(payload: params);
  }
}
