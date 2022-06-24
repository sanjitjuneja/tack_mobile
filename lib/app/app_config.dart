import 'package:core/constants/url_constants.dart';

enum Flavor {
  dev,
  staging,
  production,
}

class AppConfig {
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
        baseUrl = UrlConstants.developmentUrl;
        break;
      case Flavor.staging:
        baseUrl = UrlConstants.stagingUrl;
        break;
      case Flavor.production:
        baseUrl = UrlConstants.productionUrl;
        break;
    }

    return AppConfig(flavor, baseUrl);
  }
}
