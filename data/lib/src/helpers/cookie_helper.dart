import 'package:dio/dio.dart';

class CookiesHelper {
  final String token;
  final String sessionId;

  CookiesHelper({
    required this.token,
    required this.sessionId,
  });

  static const String accessTokenName = 'csrftoken';
  static const String sessionIdName = 'sessionid';

  List<String> get cookiesList => [token, sessionId];

  String get forHeader => cookiesList.join('; ');

  factory CookiesHelper.fromResponse(Response response) {
    final cookieList = response.headers.map['set-cookie'];
    String token = '';
    String sessionId = '';

    for (final cookieWithData in cookieList!) {
      final data =  cookieWithData.split(';')[0];
      if (cookieWithData.startsWith(accessTokenName)) {
        token = data;
      } else if (cookieWithData.contains(sessionIdName)) {
        sessionId = cookieWithData;
      }
    }

    return CookiesHelper(
      token: token,
      sessionId: sessionId,
    );
  }

  factory CookiesHelper.fromSharedPreferences(List<String> cookies) {
    return CookiesHelper(
      token: cookies[0],
      sessionId: cookies[1],
    );
  }
}
