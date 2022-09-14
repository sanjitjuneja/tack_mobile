import 'package:domain/domain.dart' as domain;

import '../entities/entities.dart';
import 'shared_preferences_provider.dart';
import 'session_api_provider.dart';

class SessionProvider {
  final SessionApiProvider _apiProvider;
  final SharedPreferencesProvider _sharedPreferencesProvider;

  const SessionProvider(
    this._apiProvider,
    this._sharedPreferencesProvider,
  );

  Future<Session?> getCurrentSession() async {
    if (await isSessionValid()) {
      return _sharedPreferencesProvider.getSession();
    }

    return null;
  }

  Future<bool> isSessionValid() async {
    final Session? session = _sharedPreferencesProvider.getSession();
    if (session == null) return false;

    if (!session.shouldRefresh) {
      return true;
    } else if (session.canRefresh) {
      // catch network error.
      try {
        await _refreshSession(session);
      } catch (_) {}

      return true;
    } else {
      return false;
    }
  }

  Future<Session> startSession({
    required domain.SignInPayload payload,
    required String? firebaseToken,
    required String? deviceName,
    required String? deviceId,
    required String deviceType,
  }) async {
    final Session session = await _apiProvider.startSession(
      request: StartSessionRequest(
        password: payload.password,
        phoneNumber: payload.login,
        firebaseToken: firebaseToken,
        deviceName: deviceName,
        deviceId: deviceId,
        deviceType: deviceType,
      ),
    );
    await _sharedPreferencesProvider.setSession(session);

    return session;
  }

  Future<Session> _refreshSession(Session oldSession) async {
    final Session session = await _apiProvider.refreshSession(
      request: RefreshSessionRequest(session: oldSession),
    );
    await endSession(oldSession);
    await _sharedPreferencesProvider.setSession(session);

    return session;
  }

  Future<void> endSession([Session? currentSession]) async {
    final Session session =
        currentSession ?? _sharedPreferencesProvider.getSession()!;

    return _apiProvider.endSession(
      request: EndSessionRequest(session: session),
    );
  }

  Future<void> updateSession(Session session) async {
    await endSession();
    await _sharedPreferencesProvider.setSession(session);
  }
}
