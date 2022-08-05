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

    final GroupsRepository groupsRepository = GroupsRepositoryImpl(
      apiProvider: appLocator.get<ApiProvider>(),
      userRepository: appLocator.get<UserRepository>(),
    );

    await groupsRepository.initialLoad();

    appLocator.registerSingleton<GroupsRepository>(groupsRepository);
    appLocator.registerLazySingleton<CreateGroupUseCase>(
      () => CreateGroupUseCase(
        groupsRepository: appLocator.get<GroupsRepository>(),
      ),
    );
    appLocator.registerLazySingleton<GetCurrentGroupUseCase>(
      () => GetCurrentGroupUseCase(
        groupsRepository: appLocator.get<GroupsRepository>(),
      ),
    );
    appLocator.registerLazySingleton<GetGroupsUseCase>(
      () => GetGroupsUseCase(
        groupsRepository: appLocator.get<GroupsRepository>(),
      ),
    );
    appLocator.registerLazySingleton<LoadGroupUseCase>(
      () => LoadGroupUseCase(
        groupsRepository: appLocator.get<GroupsRepository>(),
      ),
    );
    appLocator.registerLazySingleton<LoadGroupsUseCase>(
      () => LoadGroupsUseCase(
        groupsRepository: appLocator.get<GroupsRepository>(),
      ),
    );
    appLocator.registerLazySingleton<ObserveCurrentGroupUseCase>(
      () => ObserveCurrentGroupUseCase(
        groupsRepository: appLocator.get<GroupsRepository>(),
      ),
    );
    appLocator.registerLazySingleton<ObserveGroupsUseCase>(
      () => ObserveGroupsUseCase(
        groupsRepository: appLocator.get<GroupsRepository>(),
      ),
    );
    appLocator.registerLazySingleton<SelectGroupUseCase>(
      () => SelectGroupUseCase(
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
    appLocator.registerLazySingleton<GetRunnerTacksUseCase>(
      () => GetRunnerTacksUseCase(
        tacksRepository: appLocator.get<TacksRepository>(),
      ),
    );
    appLocator.registerLazySingleton<GetTackerTacksUseCase>(
          () => GetTackerTacksUseCase(
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

    appLocator.unregister<GetCurrentGroupUseCase>();
    appLocator.unregister<GetGroupsUseCase>();
    appLocator.unregister<LoadGroupUseCase>();
    appLocator.unregister<LoadGroupsUseCase>();
    appLocator.unregister<ObserveCurrentGroupUseCase>();
    appLocator.unregister<ObserveGroupsUseCase>();
    appLocator.unregister<SelectGroupUseCase>();

    appLocator.unregister<TacksRepository>();
    appLocator.unregister<GetGroupTacksUseCase>();
    appLocator.unregister<GetRunnerTacksUseCase>();
    appLocator.unregister<GetTackerTacksUseCase>();
    appLocator.unregister<RateTackUseCase>();
    appLocator.unregister<EditTackUseCase>();

    appLocator.unregister<LogOutUseCase>();
  }
}
