enum Flavor {
  dev,
  staging,
  production,
}

class AppConfig {
  static const String stagingUrl = 'http://44.203.217.242:8020/api/v1/';
  static const String productionUrl = 'http://44.203.217.242:8020/api/v1/';
  static const String developmentUrl = 'http://44.203.217.242:8020/api/v1/';

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
        break;
      case Flavor.staging:
        baseUrl = stagingUrl;
        break;
      case Flavor.production:
        baseUrl = productionUrl;
        break;
    }

    return AppConfig(flavor, baseUrl);
  }
}
