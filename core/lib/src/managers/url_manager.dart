import 'package:flutter/cupertino.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:url_launcher/url_launcher.dart';

import 'toast_manager.dart';

class UrlManager {
  static bool isValidUrl(String? url) {
    if (url == null) return false;

    final Uri? uri = Uri.tryParse(url);

    return <bool?>[
      uri?.hasScheme,
      uri?.hasAuthority,
      !(uri?.hasEmptyPath ?? true),
    ].every(
      (element) => element == true,
    );
  }

  static Future<bool?> openUrl(
    BuildContext context,
    String? url,
  ) async {
    Uri uri = Uri.parse(url ?? '');
    if (uri.scheme.isEmpty) {
      uri = Uri.https(url ?? '', '');
    }

    if (await canLaunchUrl(uri)) {
      return launchUrl(uri);
    } else {
      return ToastManager.showToast(
        context,
        gravity: ToastGravity.BOTTOM,
        messageKey: 'errors.couldNotLaunchURL',
      );
    }
  }

  static Future<bool?> openUrlFromTranslation(
    BuildContext context, {
    required String translationKey,
  }) async {
    String? url = FlutterI18n.translate(context, translationKey);
    if (url == translationKey) url = null;

    return openUrl(context, url);
  }
}
