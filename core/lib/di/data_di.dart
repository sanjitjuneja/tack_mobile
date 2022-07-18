import 'package:data/errors/error_handler.dart';
import 'package:data/repositories/auth_repository_impl.dart';
import 'package:data/repositories/phone_number_repository_impl.dart';
import 'package:domain/repositories/auth_repository.dart';
import 'package:domain/repositories/phone_number_repository.dart';
import 'package:domain/usecases/request_sms_code_usecase.dart';
import 'package:domain/usecases/sign_in_usecase.dart';
import 'package:domain/usecases/sign_up_usecase.dart';
import 'package:domain/usecases/verify_phone_number_usecase.dart';
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

    appLocator.registerLazySingleton<PhoneVerificationRepository>(
      () => PhoneNumberRepositoryImpl(
        apiProvider: appLocator.get<ApiProvider>(),
        prefsProvider: appLocator.get<PrefsProvider>(),
      ),
    );

    appLocator.registerLazySingleton<AuthRepository>(
      () => AuthRepositoryImpl(
        apiProvider: appLocator.get<ApiProvider>(),
      ),
    );

    appLocator.registerLazySingleton<RequestSmsCodeUseCase>(
      () => RequestSmsCodeUseCase(
        phoneNumberRepository: appLocator.get<PhoneVerificationRepository>(),
      ),
    );

    appLocator.registerLazySingleton<SignInUseCase>(
      () => SignInUseCase(
        authRepository: appLocator.get<AuthRepository>(),
      ),
    );

    appLocator.registerLazySingleton<SignUpUseCase>(
      () => SignUpUseCase(
        authRepository: appLocator.get<AuthRepository>(),
      ),
    );

    appLocator.registerLazySingleton<VerifyPhoneNumberUsecase>(
      () => VerifyPhoneNumberUsecase(
        phoneNumberRepository: appLocator.get<PhoneVerificationRepository>(),
      ),
    );
  }

  Future<SharedPreferences> _initSharedPreferences() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();

    return sharedPreferences;
  }
}
