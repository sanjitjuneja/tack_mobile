import 'package:data/errors/error_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:data/providers/access_provider.dart';
import 'package:data/providers/api_provider.dart';
import 'package:data/providers/api_provider_base.dart';
import 'package:data/providers/prefs_provider.dart';

import 'app_di.dart';

final DataDI dataDI = DataDI();

class DataDI {
  Future<void> initDependencies({required String baseUrl}) async {
    final SharedPreferences sharedPreferences = await _initSharedPreferences();

    appLocator.registerLazySingleton<PrefsProvider>(
      () => PrefsProvider(
        sharedPreferences: sharedPreferences,
      ),
    );

    appLocator.registerLazySingleton<AccessProvider>(
      () => AccessProvider(
        prefsProvider: appLocator.get<PrefsProvider>(),
      ),
    );

    appLocator.registerLazySingleton<ErrorHandler>(
      () => ErrorHandler(),
    );

    appLocator.registerLazySingleton<ApiProviderBase>(
      () => ApiProviderBase(
        accessProvider: appLocator.get<AccessProvider>(),
        errorHandler: appLocator.get<ErrorHandler>(),
        baseUrl: baseUrl,
      ),
    );

    appLocator.registerLazySingleton<ApiProvider>(
      () => ApiProvider(
        baseUrl: baseUrl,
        apiProviderBase: appLocator.get<ApiProviderBase>(),
      ),
    );
  }

  Future<SharedPreferences> _initSharedPreferences() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();

    return sharedPreferences;
  }
}
