import 'package:domain/params_models/sign_up_params.dart';
import 'package:domain/repositories/auth_repository.dart';
import 'package:domain/usecases/usecase.dart';

class SignUpUseCase extends FutureUseCase<void, SignUpParams> {
  final AuthRepository _authRepository;

  SignUpUseCase({
    required AuthRepository authRepository,
  }) : _authRepository = authRepository;

  @override
  Future<void> execute(SignUpParams params) async {
    _authRepository.signUp(signUpParams: params);
  }
}
