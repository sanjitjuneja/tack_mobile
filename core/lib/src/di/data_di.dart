import 'package:core/src/config/app_config.dart';
import 'package:core/src/config/firebase_config_helper.dart';
import 'package:data/data.dart';
import 'package:domain/domain.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:navigation/navigation.dart';

import 'app_di.dart';

final DataDI dataDI = DataDI();

class DataDI {
  Future<void> setupPreLoginAppLocator(Flavor flavor) async {
    appLocator.registerSingleton<AppConfig>(AppConfig.fromFlavor(flavor));
    appLocator.registerSingleton<FirebaseConfigHelper>(
      FirebaseConfigHelper.fromFlavor(flavor),
    );

    await Firebase.initializeApp(
      options: appLocator.get<FirebaseConfigHelper>().currentPlatformOptions,
    );

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

    final DeeplinkRepository deeplinkRepository = DeeplinkRepositoryImpl(
      firebaseConfigHelper: appLocator.get<FirebaseConfigHelper>(),
    );

    appLocator.registerSingleton<DeeplinkRepository>(deeplinkRepository);
    await deeplinkRepository.configure();

    appLocator.registerLazySingleton<CreateDeeplinkUseCase>(
      () => CreateDeeplinkUseCase(
        deeplinkRepository: appLocator.get<DeeplinkRepository>(),
      ),
    );
    appLocator.registerLazySingleton<GetLastDeeplinkUseCase>(
      () => GetLastDeeplinkUseCase(
        deeplinkRepository: appLocator.get<DeeplinkRepository>(),
      ),
    );
    appLocator.registerLazySingleton<ObserveDeeplinkUseCase>(
      () => ObserveDeeplinkUseCase(
        deeplinkRepository: appLocator.get<DeeplinkRepository>(),
      ),
    );
    appLocator.registerLazySingleton<ResetLastDeeplinkUseCase>(
      () => ResetLastDeeplinkUseCase(
        deeplinkRepository: appLocator.get<DeeplinkRepository>(),
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
      sharedPreferencesProvider: appLocator.get<SharedPreferencesProvider>(),
    );

    await groupsRepository.initialLoad();

    appLocator.registerSingleton<GroupsRepository>(groupsRepository);
    appLocator.registerLazySingleton<AcceptGroupInvitationUseCase>(
      () => AcceptGroupInvitationUseCase(
        groupsRepository: appLocator.get<GroupsRepository>(),
      ),
    );
    appLocator.registerLazySingleton<CreateGroupUseCase>(
      () => CreateGroupUseCase(
        groupsRepository: appLocator.get<GroupsRepository>(),
      ),
    );
    appLocator.registerLazySingleton<DeclineGroupInvitationUseCase>(
      () => DeclineGroupInvitationUseCase(
        groupsRepository: appLocator.get<GroupsRepository>(),
      ),
    );
    appLocator.registerLazySingleton<GetCurrentGroupUseCase>(
      () => GetCurrentGroupUseCase(
        groupsRepository: appLocator.get<GroupsRepository>(),
      ),
    );
    appLocator.registerLazySingleton<GetGroupInviteUseCase>(
      () => GetGroupInviteUseCase(
        groupsRepository: appLocator.get<GroupsRepository>(),
      ),
    );
    appLocator.registerLazySingleton<GetGroupsUseCase>(
      () => GetGroupsUseCase(
        groupsRepository: appLocator.get<GroupsRepository>(),
      ),
    );
    appLocator.registerLazySingleton<LeaveGroupUseCase>(
      () => LeaveGroupUseCase(
        groupsRepository: appLocator.get<GroupsRepository>(),
      ),
    );
    appLocator.registerLazySingleton<LoadGroupInvitationsUseCase>(
      () => LoadGroupInvitationsUseCase(
        groupsRepository: appLocator.get<GroupsRepository>(),
      ),
    );
    appLocator.registerLazySingleton<LoadGroupInviteLinkUseCase>(
      () => LoadGroupInviteLinkUseCase(
        groupsRepository: appLocator.get<GroupsRepository>(),
      ),
    );
    appLocator.registerLazySingleton<LoadGroupMembersUseCase>(
      () => LoadGroupMembersUseCase(
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
    appLocator.registerLazySingleton<MuteGroupUseCase>(
      () => MuteGroupUseCase(
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
    appLocator.registerLazySingleton<UnMuteGroupUseCase>(
      () => UnMuteGroupUseCase(
        groupsRepository: appLocator.get<GroupsRepository>(),
      ),
    );

    appLocator.registerSingleton<TacksRepository>(
      TacksRepositoryImpl(
        apiProvider: appLocator.get<ApiProvider>(),
      ),
    );
    appLocator.registerLazySingleton<AcceptOfferUseCase>(
      () => AcceptOfferUseCase(
        tacksRepository: appLocator.get<TacksRepository>(),
      ),
    );
    appLocator.registerLazySingleton<CancelOfferUseCase>(
      () => CancelOfferUseCase(
        tacksRepository: appLocator.get<TacksRepository>(),
      ),
    );
    appLocator.registerLazySingleton<CancelTackRunnerUseCase>(
      () => CancelTackRunnerUseCase(
        tacksRepository: appLocator.get<TacksRepository>(),
      ),
    );
    appLocator.registerLazySingleton<CancelTackTackerUseCase>(
      () => CancelTackTackerUseCase(
        tacksRepository: appLocator.get<TacksRepository>(),
      ),
    );
    appLocator.registerLazySingleton<CompleteTackRunnerUseCase>(
      () => CompleteTackRunnerUseCase(
        tacksRepository: appLocator.get<TacksRepository>(),
      ),
    );
    appLocator.registerLazySingleton<CompleteTackTackerUseCase>(
      () => CompleteTackTackerUseCase(
        tacksRepository: appLocator.get<TacksRepository>(),
      ),
    );
    appLocator.registerLazySingleton<CreateTackUseCase>(
      () => CreateTackUseCase(
        tacksRepository: appLocator.get<TacksRepository>(),
      ),
    );
    appLocator.registerLazySingleton<EditTackUseCase>(
      () => EditTackUseCase(
        tacksRepository: appLocator.get<TacksRepository>(),
      ),
    );
    appLocator.registerLazySingleton<GetGroupPopularTacksUseCase>(
      () => GetGroupPopularTacksUseCase(
        tacksRepository: appLocator.get<TacksRepository>(),
      ),
    );
    appLocator.registerLazySingleton<GetGroupTacksUseCase>(
      () => GetGroupTacksUseCase(
        tacksRepository: appLocator.get<TacksRepository>(),
      ),
    );
    appLocator.registerLazySingleton<GetNearbyPopularTacksUseCase>(
      () => GetNearbyPopularTacksUseCase(
        tacksRepository: appLocator.get<TacksRepository>(),
      ),
    );
    appLocator.registerLazySingleton<GetRunnerTacksUseCase>(
      () => GetRunnerTacksUseCase(
        tacksRepository: appLocator.get<TacksRepository>(),
      ),
    );
    appLocator.registerLazySingleton<GetTackOffersUseCase>(
      () => GetTackOffersUseCase(
        tacksRepository: appLocator.get<TacksRepository>(),
      ),
    );
    appLocator.registerLazySingleton<GetTackerTacksUseCase>(
      () => GetTackerTacksUseCase(
        tacksRepository: appLocator.get<TacksRepository>(),
      ),
    );
    appLocator.registerLazySingleton<MakeOfferUseCase>(
      () => MakeOfferUseCase(
        tacksRepository: appLocator.get<TacksRepository>(),
      ),
    );
    appLocator.registerLazySingleton<RateTackUseCase>(
      () => RateTackUseCase(
        tacksRepository: appLocator.get<TacksRepository>(),
      ),
    );
    appLocator.registerLazySingleton<StartTackRunnerUseCase>(
      () => StartTackRunnerUseCase(
        tacksRepository: appLocator.get<TacksRepository>(),
      ),
    );

    appLocator.registerSingleton<PaymentRepository>(
      PaymentRepositoryImpl(
        apiProvider: appLocator.get<ApiProvider>(),
        appConfig: appLocator.get<AppConfig>(),
      ),
    );
    appLocator.registerLazySingleton<AddCardUseCase>(
      () => AddCardUseCase(
        paymentRepository: appLocator.get<PaymentRepository>(),
      ),
    );
    appLocator.registerLazySingleton<AddBankAccountUseCase>(
      () => AddBankAccountUseCase(
        paymentRepository: appLocator.get<PaymentRepository>(),
      ),
    );

    appLocator.registerLazySingleton<FetchConnectedBankAccountsUseCase>(
      () => FetchConnectedBankAccountsUseCase(
        paymentRepository: appLocator.get<PaymentRepository>(),
      ),
    );

    appLocator.registerLazySingleton<FetchConnectedCardsUseCase>(
      () => FetchConnectedCardsUseCase(
        paymentRepository: appLocator.get<PaymentRepository>(),
      ),
    );

    appLocator.registerLazySingleton<FetchIsApplePaySupportedUseCase>(
      () => FetchIsApplePaySupportedUseCase(
        paymentRepository: appLocator.get<PaymentRepository>(),
      ),
    );

    appLocator.registerLazySingleton<FetchIsGooglePaySupportedUseCase>(
      () => FetchIsGooglePaySupportedUseCase(
        paymentRepository: appLocator.get<PaymentRepository>(),
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
    appLocator.unregister<AcceptGroupInvitationUseCase>();
    appLocator.unregister<CreateGroupUseCase>();
    appLocator.unregister<DeclineGroupInvitationUseCase>();
    appLocator.unregister<GetCurrentGroupUseCase>();
    appLocator.unregister<GetGroupInviteUseCase>();
    appLocator.unregister<GetGroupsUseCase>();
    appLocator.unregister<LeaveGroupUseCase>();
    appLocator.unregister<LoadGroupInvitationsUseCase>();
    appLocator.unregister<LoadGroupInviteLinkUseCase>();
    appLocator.unregister<LoadGroupMembersUseCase>();
    appLocator.unregister<LoadGroupUseCase>();
    appLocator.unregister<LoadGroupsUseCase>();
    appLocator.unregister<MuteGroupUseCase>();
    appLocator.unregister<ObserveCurrentGroupUseCase>();
    appLocator.unregister<ObserveGroupsUseCase>();
    appLocator.unregister<SelectGroupUseCase>();
    appLocator.unregister<UnMuteGroupUseCase>();

    appLocator.unregister<TacksRepository>();
    appLocator.unregister<AcceptOfferUseCase>();
    appLocator.unregister<CancelOfferUseCase>();
    appLocator.unregister<CancelTackRunnerUseCase>();
    appLocator.unregister<CancelTackTackerUseCase>();
    appLocator.unregister<CompleteTackRunnerUseCase>();
    appLocator.unregister<CompleteTackTackerUseCase>();
    appLocator.unregister<CreateTackUseCase>();
    appLocator.unregister<EditTackUseCase>();
    appLocator.unregister<GetGroupPopularTacksUseCase>();
    appLocator.unregister<GetGroupTacksUseCase>();
    appLocator.unregister<GetNearbyPopularTacksUseCase>();
    appLocator.unregister<GetRunnerTacksUseCase>();
    appLocator.unregister<GetTackOffersUseCase>();
    appLocator.unregister<GetTackerTacksUseCase>();
    appLocator.unregister<MakeOfferUseCase>();
    appLocator.unregister<RateTackUseCase>();
    appLocator.unregister<StartTackRunnerUseCase>();

    appLocator.unregister<PaymentRepository>();
    appLocator.unregister<AddCardUseCase>();
    appLocator.unregister<AddBankAccountUseCase>();
    appLocator.unregister<FetchConnectedCardsUseCase>();
    appLocator.unregister<FetchConnectedBankAccountsUseCase>();
    appLocator.unregister<FetchIsApplePaySupportedUseCase>();
    appLocator.unregister<FetchIsGooglePaySupportedUseCase>();

    appLocator.unregister<LogOutUseCase>();
  }
}
