enum Flavor {
  dev,
  staging,
  production,
}

class AppConfig {
  static const String developmentUrl = 'http://44.203.217.242/api/v1/';
  static const String stagingUrl = 'http://44.203.217.242/api/v1/';
  static const String productionUrl = 'http://44.203.217.242/api/v1/';

  static const String developmentWebSocketsUrl = 'ws://44.203.217.242/ws/';
  static const String stagingWebSocketsUrl = 'ws://44.203.217.242/ws/';
  static const String productionWebSocketsUrl = 'ws://44.203.217.242/ws/';

  static const String stripeDevelopmentKey =
      'pk_test_51KYDDWHUDqRuKWfqG347VI2pG1CgnOApLRuoqeZZ4A0ZHBuOh5QapxVwJ9XLh5pZREboD3HyvbZl97VI1TlZsVqr00gRuftswA';
  static const String stripeStagingKey =
      'pk_live_51KYDDWHUDqRuKWfqP9RhiTx6ZQitCGuLj0XJDwn6VA8NYQfdUgg8nd0mtNO8x1ZW3aEaKAzLGl5ZHEJx7UtYvBqV000LqPBbZu';
  static const String stripeProductionKey =
      'pk_live_51KYDDWHUDqRuKWfqP9RhiTx6ZQitCGuLj0XJDwn6VA8NYQfdUgg8nd0mtNO8x1ZW3aEaKAzLGl5ZHEJx7UtYvBqV000LqPBbZu';

  final Flavor flavor;
  final String baseUrl;
  final String webSocketsUrl;
  final String stripeKey;

  AppConfig._(
    this.flavor,
    this.baseUrl,
    this.webSocketsUrl,
    this.stripeKey,
  );

  factory AppConfig.fromFlavor(Flavor flavor) {
    final String baseUrl;
    final String webSocketsUrl;
    final String stripeKey;

    switch (flavor) {
      case Flavor.dev:
        baseUrl = developmentUrl;
        webSocketsUrl = developmentWebSocketsUrl;
        stripeKey = stripeDevelopmentKey;
        break;
      case Flavor.staging:
        baseUrl = stagingUrl;
        webSocketsUrl = stagingWebSocketsUrl;
        stripeKey = stripeStagingKey;
        break;
      case Flavor.production:
        baseUrl = productionUrl;
        webSocketsUrl = productionWebSocketsUrl;
        stripeKey = stripeProductionKey;
        break;
    }

    return AppConfig._(
      flavor,
      baseUrl,
      webSocketsUrl,
      stripeKey,
    );
  }
}
