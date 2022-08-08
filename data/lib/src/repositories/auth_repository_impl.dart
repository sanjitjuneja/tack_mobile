import 'package:core/core.dart';
import 'package:data/src/entities/entities.dart';
import 'package:data/src/providers/api_provider.dart';
import 'package:data/src/providers/session_provider.dart';
import 'package:data/src/providers/shared_preferences_provider.dart';
import 'package:domain/domain.dart' as domain;
import 'package:domain/user/user.dart';

class AuthRepositoryImpl implements domain.AuthRepository {
  final ApiProvider _apiProvider;
  final SessionProvider _sessionProvider;
  final SharedPreferencesProvider _sharedPreferencesProvider;

  AuthRepositoryImpl({
    required ApiProvider apiProvider,
    required SessionProvider sessionProvider,
    required SharedPreferencesProvider sharedPreferencesProvider,
  })  : _apiProvider = apiProvider,
        _sessionProvider = sessionProvider,
        _sharedPreferencesProvider = sharedPreferencesProvider;

  @override
  Future<domain.SmsCodeResult> requestSmsCode({
    required domain.RequestSmsCodePayload payload,
  }) async {
    final SmsCodeRequest request =
        SmsCodeRequest(phoneNumber: payload.phoneNumber);

    if (payload.phoneVerificationType == domain.PhoneVerificationType.signUp) {
      return _apiProvider.requestSighUpSmsCode(request: request);
    } else {
      return _apiProvider.requestResetPasswordSmsCode(request: request);
    }
  }

  @override
  Future<domain.PhoneVerificationResult> verifyPhoneNumber({
    required domain.VerifyPhoneNumberPayload params,
  }) async {
    return _apiProvider.verifyPhoneNumber(
      request: VerifyPhoneNumberRequest(
        uuid: params.uuid,
        smsCode: params.smsCode,
      ),
    );
  }

  @override
  Future<domain.User> signIn({
    required domain.SignInPayload payload,
  }) async {
    await _sessionProvider.startSession(
      payload: payload,
    );

    final User user = await _apiProvider.getUser();
    await _sharedPreferencesProvider.setUser(user);

    await _sharedPreferencesProvider.setAuthorized();
    await dataDI.setupPostLoginAppLocator();

    return user;
  }

  @override
  Future<domain.User> signUp({
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

  @override
  Future<bool> isAuthorized() async {
    final bool isAuthorized = _sharedPreferencesProvider.isAuthorized();
    final bool isSessionValid = await _sessionProvider.isSessionValid();
    final bool isAllSetForLogin = _sharedPreferencesProvider.isAllSetForLogin();

    return <bool>[
      isAuthorized,
      isSessionValid,
      isAllSetForLogin,
    ].every((bool element) => element == true);
  }

  @override
  Future<void> logout() async {
    try {
      await _sessionProvider.endSession();
    } catch (_) {
    } finally {
      await _sharedPreferencesProvider.clearSessionInfo();
    }
  }
}
