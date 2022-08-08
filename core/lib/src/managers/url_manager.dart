import 'package:core/core.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:url_launcher/url_launcher.dart';

class UrlManager {
  static Future<bool?> openUrl(BuildContext context, String? url) async {
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
}
