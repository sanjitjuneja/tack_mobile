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
        baseUrl = BseUrlConstants.developmentUrl;
        break;
      case Flavor.staging:
        baseUrl = BseUrlConstants.stagingUrl;
        break;
      case Flavor.production:
        baseUrl = BseUrlConstants.productionUrl;
        break;
    }

    return AppConfig(flavor, baseUrl);
  }
}
