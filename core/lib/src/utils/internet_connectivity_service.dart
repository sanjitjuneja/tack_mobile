import 'package:connectivity_plus/connectivity_plus.dart';

class InternetConnectionService {
  static Future<bool> get isConnected async {
    final ConnectivityResult connectionType =
        await Connectivity().checkConnectivity();
    return connectionType != ConnectivityResult.none;
  }

  static Stream<ConnectivityResult> get onConnectivityChanged {
    return Connectivity().onConnectivityChanged;
  }
}
