import 'package:core/constants/constants.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

class TokenHelper {
  static bool shouldRefresh(String accessToken) {
    return _getTokenExpirationTime(accessToken).inSeconds *
            Constants.kAccessTokenCriticalPartLifeTime >
        _getRemainingAccessTokenTime(accessToken).inSeconds;
  }

  static bool canRefresh(String refreshToken) {
    final DateTime tokenExpireDate = _getRefreshTokenExpireDate(refreshToken);
    return tokenExpireDate.isAfter(DateTime.now());
  }

  static Duration _getTokenExpirationTime(String accessToken) =>
      _getAccessTokenLifeTime(accessToken) +
      _getRemainingAccessTokenTime(accessToken);

  static DateTime _getRefreshTokenExpireDate(String refreshToken) =>
      JwtDecoder.getExpirationDate(refreshToken);

  static Duration _getAccessTokenLifeTime(String accessToken) =>
      JwtDecoder.getTokenTime(accessToken);

  static Duration _getRemainingAccessTokenTime(String accessToken) =>
      JwtDecoder.getRemainingTime(accessToken);
}
