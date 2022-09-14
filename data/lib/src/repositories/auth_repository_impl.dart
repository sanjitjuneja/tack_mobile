import 'package:core/core.dart';
import 'package:domain/domain.dart' as domain;

import '../entities/entities.dart';
import '../providers/api_provider.dart';
import '../providers/session_provider.dart';
import '../providers/shared_preferences_provider.dart';

class AuthRepositoryImpl implements domain.AuthRepository {
  final ApiProvider _apiProvider;
  final domain.NotificationsRepository _notificationsRepository;
  final SessionProvider _sessionProvider;
  final SharedPreferencesProvider _sharedPreferencesProvider;

  AuthRepositoryImpl({
    required ApiProvider apiProvider,
    required domain.NotificationsRepository notificationsRepository,
    required SessionProvider sessionProvider,
    required SharedPreferencesProvider sharedPreferencesProvider,
  })  : _apiProvider = apiProvider,
        _notificationsRepository = notificationsRepository,
        _sessionProvider = sessionProvider,
        _sharedPreferencesProvider = sharedPreferencesProvider;

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
  Future<domain.SmsCodeResult> requestSignUpSmsCode({
    required domain.RequestSmsCodePayload payload,
  }) async {
    return _apiProvider.requestSighUpSmsCode(
      request: SmsCodeRequest(
        phoneNumber: payload.phoneNumber,
      ),
    );
  }

  @override
  Future<domain.SmsCodeResult> requestRecoverySmsCode({
    required domain.RequestSmsCodePayload payload,
  }) async {
    return _apiProvider.requestResetPasswordSmsCode(
      request: SmsCodeRequest(
        phoneNumber: payload.phoneNumber,
      ),
    );
  }

  @override
  Future<domain.User> signIn({
    required domain.SignInPayload payload,
  }) async {
    final String? firebaseToken = await _notificationsRepository.getToken();
    final String? fingerprint = await PlatformInfoManager.getDeviceId();
    final String? deviceName = await PlatformInfoManager.getDeviceModel();
    final String deviceType = await PlatformInfoManager.getDeviceType();

    await _sessionProvider.startSession(
      payload: payload,
      firebaseToken: firebaseToken,
      deviceId: fingerprint,
      deviceName: deviceName,
      deviceType: deviceType,
    );

    final domain.User user = await _apiProvider.getUser();

    await _sharedPreferencesProvider.setUser(user);
    await _sharedPreferencesProvider.setActiveGroupId(user.activeGroup);

    await _sharedPreferencesProvider.setAuthorized();
    await dataDI.setupPostLoginAppLocator();

    return user;
  }

  @override
  Future<domain.User> signUp({
    required domain.SignUpByPhonePayload payload,
  }) async {
    return _apiProvider.signUp(
      request: RegisterUserByPhoneRequest(
        uuid: payload.uuid,
        user: UserRequest(
          password: payload.password,
          firstName: payload.firstName,
          lastName: payload.lastName,
          email: payload.email,
          phoneNumber: payload.phoneNumber,
        ),
      ),
    );
  }

  @override
  Future<void> recoveryChangePassword({
    required domain.RecoveryChangePasswordPayload payload,
  }) async {
    return _apiProvider.recoveryChangePassword(
      request: RecoveryChangePasswordRequest(
        uuid: payload.uuid,
        newPassword: payload.password,
      ),
    );
  }

  @override
  Future<bool> isAuthorized() async {
    try {
      final bool isAuthorized = _sharedPreferencesProvider.isAuthorized();
      final bool isSessionValid = await _sessionProvider.isSessionValid();
      final bool isAllSetForLogin =
          _sharedPreferencesProvider.isAllSetForLogin();

      return <bool>[
        isAuthorized,
        isSessionValid,
        isAllSetForLogin,
      ].every((bool element) => element == true);
    } catch (_) {
      return false;
    }
  }

  @override
  Future<void> logout() async {
    try {
      await _notificationsRepository.deactivateToken();
      await _sessionProvider.endSession();
    } catch (_) {
    } finally {
      await _sharedPreferencesProvider.clearSessionInfo();
    }
  }
}
