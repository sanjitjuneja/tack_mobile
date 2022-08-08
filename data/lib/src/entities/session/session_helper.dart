part of session_entity;

extension TokenHelper on Session {
  bool get shouldRefresh {
    final int tokenLifeTimeInSeconds =
        JwtDecoder.getTokenTime(accessToken).inSeconds;
    final int tokenRemainingLifeTimeInSeconds = JwtDecoder.getRemainingTime(
      accessToken,
    ).inSeconds;

    final double criticalLifeTime =
        (tokenLifeTimeInSeconds + tokenRemainingLifeTimeInSeconds) *
            Constants.tokenCriticalLifeTimePercent;

    return criticalLifeTime > tokenRemainingLifeTimeInSeconds;
  }

  bool get canRefresh {
    final DateTime tokenExpireDate = JwtDecoder.getExpirationDate(
      refreshToken,
    );

    return !tokenExpireDate.isBefore(DateTime.now());
  }
}