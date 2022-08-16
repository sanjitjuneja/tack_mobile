import 'package:core/src/config/app_config.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';

import '../firebase_options/firebase_options_dev.dart' as dev;
import '../firebase_options/firebase_options_production.dart' as production;
import '../firebase_options/firebase_options_staging.dart' as staging;

class FirebaseConfigHelper {
  static const String _productionLinkUriPrefix = 'https://tackapp.page.link';
  static const String _stagingLinkUriPrefix = 'https://tackappstaging.page.link';
  static const String _devLinkUriPrefix = 'https://tackappdev.page.link';

  static const String _iosBundleIdBase = 'com.tackApp.ios';
  static const String _androidPackageNameBase = 'com.android.android';

  final FirebaseOptions currentPlatformOptions;
  final String deeplinkUriPrefix;
  final String iosBundleId;
  final String androidPackageName;

  FirebaseConfigHelper._(
    this.currentPlatformOptions,
    this.deeplinkUriPrefix,
    this.iosBundleId,
    this.androidPackageName,
  );

  factory FirebaseConfigHelper.fromFlavor(Flavor flavor) {
    final FirebaseOptions currentPlatformOptions;
    final String deeplinkUriPrefix;
    final String packageSuffix;

    switch (flavor) {
      case Flavor.dev:
        currentPlatformOptions = dev.DefaultFirebaseOptions.currentPlatform;
        deeplinkUriPrefix = _devLinkUriPrefix;
        packageSuffix = '.dev';
        break;
      case Flavor.staging:
        currentPlatformOptions = staging.DefaultFirebaseOptions.currentPlatform;
        deeplinkUriPrefix = _stagingLinkUriPrefix;
        packageSuffix = '.staging';
        break;
      case Flavor.production:
        currentPlatformOptions =
            production.DefaultFirebaseOptions.currentPlatform;
        deeplinkUriPrefix = _productionLinkUriPrefix;
        packageSuffix = '';
        break;
    }

    return FirebaseConfigHelper._(
      currentPlatformOptions,
      deeplinkUriPrefix,
      '$_iosBundleIdBase$packageSuffix',
      '$_androidPackageNameBase$packageSuffix',
    );
  }

  DynamicLinkParameters dynamicLinkParameters(String deeplink) {
    return DynamicLinkParameters(
      link: Uri.parse(deeplink),
      uriPrefix: deeplinkUriPrefix,
      androidParameters: AndroidParameters(
        packageName: androidPackageName,
      ),
      iosParameters: IOSParameters(
        bundleId: iosBundleId,
      ),
    );
  }
}
