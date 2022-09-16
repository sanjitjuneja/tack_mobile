enum Flavor {
  dev,
  staging,
  production,
}

class AppConfig {
  static const String developmentUrl = 'https://backend.tackapp.net/api/v1/';
  static const String stagingUrl = 'https://backend.tackapp.net/api/v1/';
  static const String productionUrl = 'https://backend.tackapp.net/api/v1/';

  static const String developmentWebSocketsUrl = 'wss://backend.tackapp.net/ws/';
  static const String stagingWebSocketsUrl = 'wss://backend.tackapp.net/ws/';
  static const String productionWebSocketsUrl = 'wss://backend.tackapp.net/ws/';

  static const String stripeDevelopmentKey =
      'pk_test_51KYDDWHUDqRuKWfqG347VI2pG1CgnOApLRuoqeZZ4A0ZHBuOh5QapxVwJ9XLh5pZREboD3HyvbZl97VI1TlZsVqr00gRuftswA';
  static const String stripeStagingKey =
      'pk_live_51KYDDWHUDqRuKWfqP9RhiTx6ZQitCGuLj0XJDwn6VA8NYQfdUgg8nd0mtNO8x1ZW3aEaKAzLGl5ZHEJx7UtYvBqV000LqPBbZu';
  static const String stripeProductionKey =
      'pk_live_51KYDDWHUDqRuKWfqP9RhiTx6ZQitCGuLj0XJDwn6VA8NYQfdUgg8nd0mtNO8x1ZW3aEaKAzLGl5ZHEJx7UtYvBqV000LqPBbZu';

  static const String merchantIdentifierDevelopment = 'merchant.com.tackApp.ios.dev';
  static const String merchantIdentifierStaging = 'merchant.com.tackApp.ios.stage';
  static const String merchantIdentifierProduction = 'merchant.com.tackApp.ios';

  final Flavor flavor;
  final String baseUrl;
  final String webSocketsUrl;
  final String stripeKey;
  final String merchantIdentifier;

  AppConfig._(
    this.flavor,
    this.baseUrl,
    this.webSocketsUrl,
    this.stripeKey,
    this.merchantIdentifier,
  );

  factory AppConfig.fromFlavor(Flavor flavor) {
    final String baseUrl;
    final String webSocketsUrl;
    final String stripeKey;
    final String merchantIdentifier;

    switch (flavor) {
      case Flavor.dev:
        baseUrl = developmentUrl;
        webSocketsUrl = developmentWebSocketsUrl;
        stripeKey = stripeDevelopmentKey;
        merchantIdentifier = merchantIdentifierDevelopment;
        break;
      case Flavor.staging:
        baseUrl = stagingUrl;
        webSocketsUrl = stagingWebSocketsUrl;
        stripeKey = stripeStagingKey;
        merchantIdentifier = merchantIdentifierStaging;
        break;
      case Flavor.production:
        baseUrl = productionUrl;
        webSocketsUrl = productionWebSocketsUrl;
        stripeKey = stripeProductionKey;
        merchantIdentifier = merchantIdentifierProduction;
        break;
    }

    return AppConfig._(
      flavor,
      baseUrl,
      webSocketsUrl,
      stripeKey,
      merchantIdentifier,
    );
  }
}
