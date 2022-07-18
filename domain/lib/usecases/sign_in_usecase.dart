import 'package:domain/repositories/auth_repository.dart';
import 'package:domain/usecases/usecase.dart';

import '../params_models/sign_in_params.dart';

class SignInUseCase extends FutureUseCase<void, SignInParams> {
  final AuthRepository _authRepository;

  SignInUseCase({
    required AuthRepository authRepository,
  }) : _authRepository = authRepository;

  @override
  Future<void> execute(SignInParams params) async {
    _authRepository.signIn(signInParams: params);
  }
}
