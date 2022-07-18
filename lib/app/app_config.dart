import 'package:core/constants/base_url_constants.dart';

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
        baseUrl = BaseUrlConstants.developmentUrl;
        break;
      case Flavor.staging:
        baseUrl = BaseUrlConstants.stagingUrl;
        break;
      case Flavor.production:
        baseUrl = BaseUrlConstants.productionUrl;
        break;
    }

    return AppConfig(flavor, baseUrl);
  }
}
