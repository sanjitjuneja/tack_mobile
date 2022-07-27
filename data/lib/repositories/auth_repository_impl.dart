import 'package:domain/auth/phone_verification.dart';
import 'package:domain/domain.dart' as domain;
import 'package:domain/repositories/auth_repository.dart';
import 'package:domain/user/user.dart';

import '../entities/user/user.dart';
import '../providers/api_provider.dart';

class AuthRepositoryImpl implements AuthRepository {
  final ApiProvider _apiProvider;

  AuthRepositoryImpl({
    required ApiProvider apiProvider,
  }) : _apiProvider = apiProvider;

  @override
  Future<domain.Message> signIn({
    required SignInPayload payload,
  }) async {
    return _apiProvider.signIn(
      request: SignInRequest(
        password: payload.password,
        phoneNumber: payload.phoneNumber,
      ),
    );
  }

  @override
  Future<domain.Customer> signUp({
    required SignUpByPhonePayload params,
  }) async {
    return _apiProvider.signUp(
      request: RegisterUserByPhoneRequest(
        uuid: params.uuid,
        user: UserRequest(
          password: params.password,
          firstName: params.firstName,
          lastName: params.lastName,
          phoneNumber: params.phoneNumber,
        ),
      ),
    );
  }
}
