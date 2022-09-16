import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';

enum DeviceType {
  ios,
  android,
}

class PlatformInfoManager {
  static Future<String?> getDeviceModel() async {
    final DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

    if (Platform.isIOS) {
      final IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      return iosInfo.utsname.machine;
    } else if (Platform.isAndroid) {
      final AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      return androidInfo.model;
    } else {
      throw Exception(
        'getDeviceId only available on iOS and Android platforms.',
      );
    }
  }

  static Future<String> getDeviceType() async {
    if (Platform.isIOS) {
      return DeviceType.ios.name;
    } else if (Platform.isAndroid) {
      return DeviceType.android.name;
    } else {
      throw Exception(
        'getDeviceId only available on iOS and Android platforms.',
      );
    }
  }

  static Future<String?> getDeviceId() async {
    final DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

    if (Platform.isIOS) {
      final IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      return iosInfo.identifierForVendor;
    } else if (Platform.isAndroid) {
      final AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      return androidInfo.id;
    } else {
      throw Exception(
        'getDeviceId only available on iOS and Android platforms.',
      );
    }
  }
}
