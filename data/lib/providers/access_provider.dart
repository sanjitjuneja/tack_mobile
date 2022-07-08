import 'package:core/core.dart';
import 'package:data/providers/prefs_provider.dart';

class AccessProvider {
  final PrefsProvider _prefsProvider;

  AccessProvider({
    required PrefsProvider prefsProvider,
  }) : _prefsProvider = prefsProvider;

  Future<String?> getAccessToken() async {
    return _prefsProvider.getAccessToken();
  }

  Future<String?> getRefreshTokenIfItActual() async {
    final String? refreshToken = _prefsProvider.getRefreshToken();

    if (refreshToken != null && TokenHelper.canRefresh(refreshToken)) {
      return refreshToken;
    } else {
      return null;
    }
  }

  Future<void> saveAccessToken({required String accessToken}) async {
    await _prefsProvider.saveAccessToken(accessToken);
  }
}
