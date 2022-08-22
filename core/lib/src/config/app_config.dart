import 'package:core/core.dart';

enum Flavor {
  dev,
  staging,
  production,
}

class AppConfig {
  static const String stagingUrl = 'http://44.203.217.242:8020/api/v1/';
  static const String productionUrl = 'http://44.203.217.242:8020/api/v1/';
  static const String developmentUrl = 'http://44.203.217.242:8020/api/v1/';

  static const String stripeDevelopmentKey =
      'pk_test_51KYDDWHUDqRuKWfqG347VI2pG1CgnOApLRuoqeZZ4A0ZHBuOh5QapxVwJ9XLh5pZREboD3HyvbZl97VI1TlZsVqr00gRuftswA';
  static const String stripeStagingKey =
      'pk_live_51KYDDWHUDqRuKWfqP9RhiTx6ZQitCGuLj0XJDwn6VA8NYQfdUgg8nd0mtNO8x1ZW3aEaKAzLGl5ZHEJx7UtYvBqV000LqPBbZu';
  static const String stripeProductionKey =
      'pk_live_51KYDDWHUDqRuKWfqP9RhiTx6ZQitCGuLj0XJDwn6VA8NYQfdUgg8nd0mtNO8x1ZW3aEaKAzLGl5ZHEJx7UtYvBqV000LqPBbZu';

  final Flavor flavor;
  final String baseUrl;

  AppConfig(
    this.flavor,
    this.baseUrl,
  );

  factory AppConfig.fromFlavor(Flavor flavor) {
    String baseUrl;
    switch (flavor) {
      case Flavor.dev:
        baseUrl = developmentUrl;
        Stripe.publishableKey = stripeDevelopmentKey;
        break;
      case Flavor.staging:
        baseUrl = stagingUrl;
        Stripe.publishableKey = stripeStagingKey;
        break;
      case Flavor.production:
        baseUrl = productionUrl;
        Stripe.publishableKey = stripeProductionKey;
        break;
    }

    return AppConfig(flavor, baseUrl);
  }
}
