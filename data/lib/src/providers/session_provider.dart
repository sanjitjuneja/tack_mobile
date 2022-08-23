import 'package:data/src/entities/entities.dart';
import 'package:data/src/providers/shared_preferences_provider.dart';
import 'package:data/src/providers/session_api_provider.dart';
import 'package:domain/domain.dart' as domain;

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
  }) async {
    final Session session = await _apiProvider.startSession(
      request: StartSessionRequest(
        password: payload.password,
        phoneNumber: payload.login,
      ),
    );
    await _sharedPreferencesProvider.setSession(session);

    return session;
  }

  Future<Session> _refreshSession(Session oldSession) async {
    final Session session = await _apiProvider.refreshSession(
      request: RefreshSessionRequest(session: oldSession),
    );
    await _apiProvider.endSession(
      request: EndSessionRequest(session: oldSession),
    );
    await _sharedPreferencesProvider.setSession(session);

    return session;
  }

  Future<void> endSession() async {
    final Session session = _sharedPreferencesProvider.getSession()!;
    await _apiProvider.endSession(
      request: EndSessionRequest(session: session),
    );
  }
}
