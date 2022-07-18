import 'package:domain/params_models/sign_in_params.dart';
import 'package:domain/params_models/sign_up_params.dart';

abstract class AuthRepository {
  Future<void> signIn({
    required SignInParams signInParams,
  });

  Future<void> signUp({
    required SignUpParams signUpParams,
  });
}
