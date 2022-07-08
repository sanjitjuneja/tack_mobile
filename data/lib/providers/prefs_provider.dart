import 'package:core/core.dart';

class PrefsProvider {
  final SharedPreferences sharedPreferences;

  PrefsProvider({
    required this.sharedPreferences,
  });

  Future<void> saveAccessToken(String accessToken) async {
    await sharedPreferences.setString(
      Constants.keyAccessToken,
      accessToken,
    );
  }

  String? getAccessToken() {
    return sharedPreferences.getString(
      Constants.keyAccessToken,
    );
  }

  Future<void> saveRefreshToken(String refreshToken) async {
    await sharedPreferences.setString(
      Constants.keyRefreshToken,
      refreshToken,
    );
  }

  String? getRefreshToken() {
    return sharedPreferences.getString(
      Constants.keyRefreshToken,
    );
  }
}
