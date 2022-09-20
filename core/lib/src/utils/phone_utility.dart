import 'package:url_launcher/url_launcher.dart';

class PhoneUtility {
  static Future<bool> callNumber(String? phoneNumber) {
    if (phoneNumber == null) return Future<bool>.value(false);

    final Uri uri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );

    return launchUrl(uri);
  }

  static Future<bool> sendSMS(String? phoneNumber) {
    if (phoneNumber == null) return Future<bool>.value(false);

    final Uri uri = Uri(
      scheme: 'sms',
      path: phoneNumber,
    );

    return launchUrl(uri);
  }
}
