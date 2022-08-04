import 'package:core/src/app_config.dart';
import 'package:data/data.dart';
import 'package:domain/domain.dart';
import 'package:navigation/navigation.dart';

import 'app_di.dart';

final DataDI dataDI = DataDI();

class DataDI {
  Future<void> setupPreLoginAppLocator(Flavor flavor) async {
    appLocator.registerSingleton<AppConfig>(AppConfig.fromFlavor(flavor));

    final MapperFactory mapperFactory = MapperFactory();

    final SharedPreferencesProvider sharedPreferencesProvider =
        SharedPreferencesProvider(mapper: mapperFactory);
    await sharedPreferencesProvider.initializeSharedPreferences();
    appLocator.registerLazySingleton<SharedPreferencesProvider>(
      () => sharedPreferencesProvider,
    );

    appLocator.registerLazySingleton<ErrorHandler>(
      () => ErrorHandler(),
    );

    appLocator.registerSingleton<SessionApiProvider>(
      SessionApiProviderImpl(
        baseUrl: appLocator.get<AppConfig>().baseUrl,
        errorHandler: appLocator.get<ErrorHandler>(),
      ),
    );

    appLocator.registerLazySingleton<SessionProvider>(
      () => SessionProvider(
        appLocator.get<SessionApiProvider>(),
        appLocator.get<SharedPreferencesProvider>(),
      ),
    );

    appLocator.registerLazySingleton<ApiProvider>(
      () => ApiProvider(
        baseUrl: appLocator.get<AppConfig>().baseUrl,
        errorHandler: appLocator.get<ErrorHandler>(),
        sessionProvider: appLocator.get<SessionProvider>(),
        mapper: MapperFactory(),
      ),
    );
    appLocator.registerLazySingleton<AuthRepository>(
      () => AuthRepositoryImpl(
        apiProvider: appLocator.get<ApiProvider>(),
        sessionProvider: appLocator.get<SessionProvider>(),
        sharedPreferencesProvider: appLocator.get<SharedPreferencesProvider>(),
      ),
    );

    appLocator.registerLazySingleton<IsAuthorizedUseCase>(
      () => IsAuthorizedUseCase(
        authRepository: appLocator.get<AuthRepository>(),
      ),
    );
    appLocator.registerLazySingleton<RequestSmsCodeUseCase>(
      () => RequestSmsCodeUseCase(
        authRepository: appLocator.get<AuthRepository>(),
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

    appLocator.registerLazySingleton<VerifyPhoneNumberUseCase>(
      () => VerifyPhoneNumberUseCase(
        authRepository: appLocator.get<AuthRepository>(),
      ),
    );
  }

  Future<void> setupPostLoginAppLocator() async {
    appLocator.registerSingleton<UserRepository>(
      UserRepositoryImpl(
        apiProvider: appLocator.get<ApiProvider>(),
        sharedPreferencesProvider: appLocator.get<SharedPreferencesProvider>(),
      ),
    );
    appLocator.registerLazySingleton<GetCurrentUserUseCase>(
      () => GetCurrentUserUseCase(
        userRepository: appLocator.get<UserRepository>(),
      ),
    );
    appLocator.registerLazySingleton<ObserveUserUseCase>(
      () => ObserveUserUseCase(
        userRepository: appLocator.get<UserRepository>(),
      ),
    );

    appLocator.registerSingleton<GroupsRepository>(
      GroupsRepositoryImpl(
        apiProvider: appLocator.get<ApiProvider>(),
      ),
    );
    appLocator.registerLazySingleton<CreateGroupUseCase>(
      () => CreateGroupUseCase(
        groupsRepository: appLocator.get<GroupsRepository>(),
      ),
    );

    appLocator.registerSingleton<TacksRepository>(
      TacksRepositoryImpl(
        apiProvider: appLocator.get<ApiProvider>(),
      ),
    );
    appLocator.registerLazySingleton<GetGroupTacksUseCase>(
      () => GetGroupTacksUseCase(
        tacksRepository: appLocator.get<TacksRepository>(),
      ),
    );
    appLocator.registerLazySingleton<GetMyTacksUseCase>(
      () => GetMyTacksUseCase(
        tacksRepository: appLocator.get<TacksRepository>(),
      ),
    );
    appLocator.registerLazySingleton<RateTackUseCase>(
      () => RateTackUseCase(
        tacksRepository: appLocator.get<TacksRepository>(),
      ),
    );
    appLocator.registerLazySingleton<EditTackUseCase>(
      () => EditTackUseCase(
        tacksRepository: appLocator.get<TacksRepository>(),
      ),
    );

    appLocator.registerLazySingleton<LogOutUseCase>(
      () => LogOutUseCase(
        globalAppRouter: appLocator.get<GlobalAppRouterDelegate>(),
        authRepository: appLocator.get<AuthRepository>(),
      ),
    );
  }

  Future<void> unregisterPostLoginAppLocator() async {
    appLocator.unregister<UserRepository>();
    appLocator.unregister<GetCurrentUserUseCase>();
    appLocator.unregister<ObserveUserUseCase>();

    appLocator.unregister<GroupsRepository>();
    appLocator.unregister<CreateGroupUseCase>();

    appLocator.unregister<TacksRepository>();
    appLocator.unregister<GetGroupTacksUseCase>();
    appLocator.unregister<GetMyTacksUseCase>();
    appLocator.unregister<RateTackUseCase>();
    appLocator.unregister<EditTackUseCase>();

    appLocator.unregister<LogOutUseCase>();
  }
}
