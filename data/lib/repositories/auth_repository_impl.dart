import 'package:data/data.dart';
import 'package:domain/params_models/sign_in_params.dart';
import 'package:domain/params_models/sign_up_params.dart';
import 'package:domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final ApiProvider _apiProvider;

  AuthRepositoryImpl({
    required ApiProvider apiProvider,
  }) : _apiProvider = apiProvider;

  @override
  Future<void> signIn({required SignInParams signInParams}) async {
    await _apiProvider.signIn(
      signInBody: signInParams.toMap(),
    );
  }

  @override
  Future<void> signUp({required SignUpParams signUpParams}) async {
    await _apiProvider.signUp(
      signUpBody: signUpParams.toMap(),
    );
  }
}
