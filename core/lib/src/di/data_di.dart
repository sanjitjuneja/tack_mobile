import 'package:data/data.dart';
import 'package:domain/domain.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:navigation/navigation.dart';

import 'app_di.dart';
import '../config/app_config.dart';
import '../config/firebase_config_helper.dart';

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

    final NotificationsRepository notificationsRepository =
        NotificationsRepositoryImpl();
    await notificationsRepository.initialize();
    appLocator.registerSingleton(notificationsRepository);

    appLocator.registerLazySingleton<RequestNotificationsPermissionsUseCase>(
      () => RequestNotificationsPermissionsUseCase(
        notificationsRepository: notificationsRepository,
      ),
    );

    appLocator.registerLazySingleton<MapperFactory>(
      () => MapperFactory(),
    );

    final SharedPreferencesProvider sharedPreferencesProvider =
        SharedPreferencesProvider(
      mapper: appLocator.get<MapperFactory>(),
    );
    await sharedPreferencesProvider.initializeSharedPreferences();
    appLocator.registerLazySingleton<SharedPreferencesProvider>(
      () => sharedPreferencesProvider,
    );

    appLocator.registerLazySingleton<ErrorHandler>(
      () => ErrorHandler(),
    );

    appLocator.registerSingleton<SessionApiProvider>(
      SessionApiProviderImpl(
        appConfig: appLocator.get<AppConfig>(),
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
        appConfig: appLocator.get<AppConfig>(),
        errorHandler: appLocator.get<ErrorHandler>(),
        sessionProvider: appLocator.get<SessionProvider>(),
        mapper: appLocator.get<MapperFactory>(),
      ),
    );
    appLocator.registerLazySingleton<AuthRepository>(
      () => AuthRepositoryImpl(
        apiProvider: appLocator.get<ApiProvider>(),
        notificationsRepository: notificationsRepository,
        sessionProvider: appLocator.get<SessionProvider>(),
        sharedPreferencesProvider: appLocator.get<SharedPreferencesProvider>(),
      ),
    );

    appLocator.registerLazySingleton<ChangePasswordRecoveryUseCase>(
      () => ChangePasswordRecoveryUseCase(
        authRepository: appLocator.get<AuthRepository>(),
      ),
    );
    appLocator.registerLazySingleton<GetRecoverySmsCodeUseCase>(
      () => GetRecoverySmsCodeUseCase(
        authRepository: appLocator.get<AuthRepository>(),
      ),
    );
    appLocator.registerLazySingleton<GetSignUpSmsCodeUseCase>(
      () => GetSignUpSmsCodeUseCase(
        authRepository: appLocator.get<AuthRepository>(),
      ),
    );
    appLocator.registerLazySingleton<IsAuthorizedUseCase>(
      () => IsAuthorizedUseCase(
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
    final AppLifeCycleProvider appLifeCycleProvider = AppLifeCycleProvider(
      globalAppRouter: appLocator.get<GlobalAppRouterDelegate>(),
    );
    appLocator.registerSingleton(appLifeCycleProvider);

    appLocator.registerLazySingleton<LogOutUseCase>(
      () => LogOutUseCase(
        globalAppRouter: appLocator.get<GlobalAppRouterDelegate>(),
        authRepository: appLocator.get<AuthRepository>(),
      ),
    );

    /// Error Handler
    final PostLoginLayerErrorHandler postLoginLayerErrorHandler =
        PostLoginLayerErrorHandler(
      globalAppRouter: appLocator.get<GlobalAppRouterDelegate>(),
      logOutUseCase: appLocator.get<LogOutUseCase>(),
    );
    appLocator.registerSingleton<PostLoginLayerErrorHandler>(
      postLoginLayerErrorHandler,
    );
    appLocator.get<ErrorHandler>().addLayerHandler(postLoginLayerErrorHandler);

    ///

    appLocator.registerLazySingleton<WebSocketsProvider>(
      () => WebSocketsProvider(
        appConfig: appLocator.get<AppConfig>(),
        sessionProvider: appLocator.get<SessionProvider>(),
        mapper: appLocator.get<MapperFactory>(),
        appLifeCycleProvider: appLifeCycleProvider,
      ),
    );

    final UserRepository userRepository = UserRepositoryImpl(
      apiProvider: appLocator.get<ApiProvider>(),
      sessionProvider: appLocator.get<SessionProvider>(),
      sharedPreferencesProvider: appLocator.get<SharedPreferencesProvider>(),
      webSocketsProvider: appLocator.get<WebSocketsProvider>(),
    );

    await userRepository.initialLoad();

    appLocator.registerSingleton<UserRepository>(userRepository);
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
    appLocator.registerLazySingleton<UpdateUserInfoUseCase>(
      () => UpdateUserInfoUseCase(
        userRepository: appLocator.get<UserRepository>(),
      ),
    );
    appLocator.registerLazySingleton<ChangePasswordUseCase>(
      () => ChangePasswordUseCase(
        userRepository: appLocator.get<UserRepository>(),
      ),
    );
    appLocator.registerLazySingleton<FetchUserBalanceUseCase>(
      () => FetchUserBalanceUseCase(
        userRepository: appLocator.get<UserRepository>(),
      ),
    );
    appLocator.registerLazySingleton<FetchUserUseCase>(
      () => FetchUserUseCase(
        userRepository: appLocator.get<UserRepository>(),
      ),
    );
    appLocator.registerLazySingleton<GetUserBalanceUseCase>(
      () => GetUserBalanceUseCase(
        userRepository: appLocator.get<UserRepository>(),
      ),
    );
    appLocator.registerLazySingleton<ObserveUserBalanceUseCase>(
      () => ObserveUserBalanceUseCase(
        userRepository: appLocator.get<UserRepository>(),
      ),
    );
    appLocator.registerLazySingleton<FetchUserContactsUseCase>(
      () => FetchUserContactsUseCase(
        userRepository: appLocator.get<UserRepository>(),
      ),
    );
    appLocator.registerLazySingleton<DeleteAccountUseCase>(
      () => DeleteAccountUseCase(
        userRepository: appLocator.get<UserRepository>(),
      ),
    );

    final GroupsRepository groupsRepository = GroupsRepositoryImpl(
      apiProvider: appLocator.get<ApiProvider>(),
      sharedPreferencesProvider: appLocator.get<SharedPreferencesProvider>(),
      webSocketsProvider: appLocator.get<WebSocketsProvider>(),
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
    appLocator.registerLazySingleton<FetchGroupInviteUseCase>(
      () => FetchGroupInviteUseCase(
        groupsRepository: appLocator.get<GroupsRepository>(),
      ),
    );
    appLocator.registerLazySingleton<GetGroupsCountUseCase>(
      () => GetGroupsCountUseCase(
        groupsRepository: appLocator.get<GroupsRepository>(),
      ),
    );
    appLocator.registerLazySingleton<LeaveGroupUseCase>(
      () => LeaveGroupUseCase(
        groupsRepository: appLocator.get<GroupsRepository>(),
      ),
    );
    appLocator.registerLazySingleton<FetchGroupInvitationsUseCase>(
      () => FetchGroupInvitationsUseCase(
        groupsRepository: appLocator.get<GroupsRepository>(),
      ),
    );
    appLocator.registerLazySingleton<FetchGroupInviteLinkUseCase>(
      () => FetchGroupInviteLinkUseCase(
        groupsRepository: appLocator.get<GroupsRepository>(),
      ),
    );
    appLocator.registerLazySingleton<FetchGroupMembersUseCase>(
      () => FetchGroupMembersUseCase(
        groupsRepository: appLocator.get<GroupsRepository>(),
      ),
    );
    appLocator.registerLazySingleton<FetchGroupUseCase>(
      () => FetchGroupUseCase(
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
    appLocator.registerLazySingleton<ObserveGroupIntentUseCase>(
      () => ObserveGroupIntentUseCase(
        groupsRepository: appLocator.get<GroupsRepository>(),
      ),
    );
    appLocator.registerLazySingleton<ObserveGroupInvitationIntentUseCase>(
      () => ObserveGroupInvitationIntentUseCase(
        groupsRepository: appLocator.get<GroupsRepository>(),
      ),
    );
    appLocator.registerLazySingleton<ObserveGroupsCountUseCase>(
      () => ObserveGroupsCountUseCase(
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
        webSocketsProvider: appLocator.get<WebSocketsProvider>(),
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
    appLocator.registerLazySingleton<FetchGroupPopularTacksUseCase>(
      () => FetchGroupPopularTacksUseCase(
        tacksRepository: appLocator.get<TacksRepository>(),
      ),
    );
    appLocator.registerLazySingleton<FetchGroupTacksUseCase>(
      () => FetchGroupTacksUseCase(
        tacksRepository: appLocator.get<TacksRepository>(),
      ),
    );
    appLocator.registerLazySingleton<FetchHasRunningTackUseCase>(
      () => FetchHasRunningTackUseCase(
        tacksRepository: appLocator.get<TacksRepository>(),
      ),
    );
    appLocator.registerLazySingleton<FetchNearbyPopularTacksUseCase>(
      () => FetchNearbyPopularTacksUseCase(
        tacksRepository: appLocator.get<TacksRepository>(),
      ),
    );
    appLocator.registerLazySingleton<FetchRunnerTacksUseCase>(
      () => FetchRunnerTacksUseCase(
        tacksRepository: appLocator.get<TacksRepository>(),
      ),
    );
    appLocator.registerLazySingleton<FetchTackOffersUseCase>(
      () => FetchTackOffersUseCase(
        tacksRepository: appLocator.get<TacksRepository>(),
      ),
    );
    appLocator.registerLazySingleton<FetchTackerTacksUseCase>(
      () => FetchTackerTacksUseCase(
        tacksRepository: appLocator.get<TacksRepository>(),
      ),
    );
    appLocator.registerLazySingleton<FetchTackUseCase>(
      () => FetchTackUseCase(
        tacksRepository: appLocator.get<TacksRepository>(),
      ),
    );
    appLocator.registerLazySingleton<FetchCompletedTacksUseCase>(
      () => FetchCompletedTacksUseCase(
        tacksRepository: appLocator.get<TacksRepository>(),
      ),
    );
    appLocator.registerLazySingleton<FetchCreatedTacksUseCase>(
      () => FetchCreatedTacksUseCase(
        tacksRepository: appLocator.get<TacksRepository>(),
      ),
    );
    appLocator.registerLazySingleton<MakeOfferUseCase>(
      () => MakeOfferUseCase(
        tacksRepository: appLocator.get<TacksRepository>(),
      ),
    );
    appLocator.registerLazySingleton<ObserveGroupTackIntentUseCase>(
      () => ObserveGroupTackIntentUseCase(
        tacksRepository: appLocator.get<TacksRepository>(),
      ),
    );
    appLocator.registerLazySingleton<ObserveOfferIntentUseCase>(
      () => ObserveOfferIntentUseCase(
        tacksRepository: appLocator.get<TacksRepository>(),
      ),
    );
    appLocator.registerLazySingleton<ObserveRunnerTackIntentUseCase>(
      () => ObserveRunnerTackIntentUseCase(
        tacksRepository: appLocator.get<TacksRepository>(),
      ),
    );
    appLocator.registerLazySingleton<ObserveCompletedTackRunnerIntentUseCase>(
      () => ObserveCompletedTackRunnerIntentUseCase(
        tacksRepository: appLocator.get<TacksRepository>(),
      ),
    );
    appLocator
        .registerLazySingleton<ObserveCancelTackerTackRunnerIntentUseCase>(
      () => ObserveCancelTackerTackRunnerIntentUseCase(
        tacksRepository: appLocator.get<TacksRepository>(),
      ),
    );
    appLocator.registerLazySingleton<ObserveTackerTackIntentUseCase>(
      () => ObserveTackerTackIntentUseCase(
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

    appLocator.registerLazySingleton<RemovePaymentMethodUseCase>(
      () => RemovePaymentMethodUseCase(
        paymentRepository: appLocator.get<PaymentRepository>(),
      ),
    );

    appLocator.registerLazySingleton<SetPrimaryPaymentMethodUseCase>(
      () => SetPrimaryPaymentMethodUseCase(
        paymentRepository: appLocator.get<PaymentRepository>(),
      ),
    );

    appLocator.registerLazySingleton<FetchFeeUseCase>(
      () => FetchFeeUseCase(
        paymentRepository: appLocator.get<PaymentRepository>(),
      ),
    );

    appLocator.registerLazySingleton<HandleStripeDepositUseCase>(
      () => HandleStripeDepositUseCase(
        paymentRepository: appLocator.get<PaymentRepository>(),
      ),
    );

    appLocator.registerLazySingleton<HandleDwollaDepositUseCase>(
      () => HandleDwollaDepositUseCase(
        paymentRepository: appLocator.get<PaymentRepository>(),
      ),
    );

    appLocator.registerLazySingleton<HandleDwollaWithdrawUseCase>(
      () => HandleDwollaWithdrawUseCase(
        paymentRepository: appLocator.get<PaymentRepository>(),
      ),
    );
  }

  Future<void> unregisterPostLoginAppLocator() async {
    appLocator.unregister<LogOutUseCase>();

    /// Error Handler
    appLocator
        .get<ErrorHandler>()
        .removeLayerHandler<PostLoginLayerErrorHandler>();
    appLocator.unregister<PostLoginLayerErrorHandler>();

    ///

    appLocator.unregister<WebSocketsProvider>(
      disposingFunction: (WebSocketsProvider webSocketsProvider) =>
          webSocketsProvider.dispose(),
    );

    appLocator.unregister<UserRepository>(
      disposingFunction: (UserRepository repository) => repository.dispose(),
    );
    appLocator.unregister<GetCurrentUserUseCase>();
    appLocator.unregister<ObserveUserUseCase>();
    appLocator.unregister<UpdateUserInfoUseCase>();
    appLocator.unregister<ChangePasswordUseCase>();
    appLocator.unregister<FetchUserBalanceUseCase>();
    appLocator.unregister<FetchUserUseCase>();
    appLocator.unregister<GetUserBalanceUseCase>();
    appLocator.unregister<ObserveUserBalanceUseCase>();
    appLocator.unregister<FetchUserContactsUseCase>();
    appLocator.unregister<DeleteAccountUseCase>();

    appLocator.unregister<GroupsRepository>(
      disposingFunction: (GroupsRepository repository) => repository.dispose(),
    );
    appLocator.unregister<AcceptGroupInvitationUseCase>();
    appLocator.unregister<CreateGroupUseCase>();
    appLocator.unregister<DeclineGroupInvitationUseCase>();
    appLocator.unregister<GetCurrentGroupUseCase>();
    appLocator.unregister<FetchGroupInviteUseCase>();
    appLocator.unregister<GetGroupsCountUseCase>();
    appLocator.unregister<LeaveGroupUseCase>();
    appLocator.unregister<FetchGroupInvitationsUseCase>();
    appLocator.unregister<FetchGroupInviteLinkUseCase>();
    appLocator.unregister<FetchGroupMembersUseCase>();
    appLocator.unregister<FetchGroupUseCase>();
    appLocator.unregister<LoadGroupsUseCase>();
    appLocator.unregister<MuteGroupUseCase>();
    appLocator.unregister<ObserveCurrentGroupUseCase>();
    appLocator.unregister<ObserveGroupIntentUseCase>();
    appLocator.unregister<ObserveGroupInvitationIntentUseCase>();
    appLocator.unregister<ObserveGroupsCountUseCase>();
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
    appLocator.unregister<FetchGroupPopularTacksUseCase>();
    appLocator.unregister<FetchGroupTacksUseCase>();
    appLocator.unregister<FetchHasRunningTackUseCase>();
    appLocator.unregister<FetchNearbyPopularTacksUseCase>();
    appLocator.unregister<FetchRunnerTacksUseCase>();
    appLocator.unregister<FetchTackOffersUseCase>();
    appLocator.unregister<FetchTackerTacksUseCase>();
    appLocator.unregister<FetchTackUseCase>();
    appLocator.unregister<FetchCompletedTacksUseCase>();
    appLocator.unregister<FetchCreatedTacksUseCase>();
    appLocator.unregister<MakeOfferUseCase>();
    appLocator.unregister<ObserveGroupTackIntentUseCase>();
    appLocator.unregister<ObserveOfferIntentUseCase>();
    appLocator.unregister<ObserveRunnerTackIntentUseCase>();
    appLocator.unregister<ObserveCompletedTackRunnerIntentUseCase>();
    appLocator.unregister<ObserveCancelTackerTackRunnerIntentUseCase>();
    appLocator.unregister<ObserveTackerTackIntentUseCase>();
    appLocator.unregister<RateTackUseCase>();
    appLocator.unregister<StartTackRunnerUseCase>();

    appLocator.unregister<PaymentRepository>();
    appLocator.unregister<AddCardUseCase>();
    appLocator.unregister<AddBankAccountUseCase>();
    appLocator.unregister<FetchConnectedCardsUseCase>();
    appLocator.unregister<FetchConnectedBankAccountsUseCase>();
    appLocator.unregister<FetchIsApplePaySupportedUseCase>();
    appLocator.unregister<FetchIsGooglePaySupportedUseCase>();
    appLocator.unregister<RemovePaymentMethodUseCase>();
    appLocator.unregister<SetPrimaryPaymentMethodUseCase>();
    appLocator.unregister<FetchFeeUseCase>();
    appLocator.unregister<HandleStripeDepositUseCase>();
    appLocator.unregister<HandleDwollaDepositUseCase>();
    appLocator.unregister<HandleDwollaWithdrawUseCase>();

    appLocator.unregister<AppLifeCycleProvider>();
  }
}
