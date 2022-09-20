import 'dart:io';

import 'package:dio/dio.dart';
import 'package:domain/domain.dart' as domain;

import 'api_provider_core.dart';
import 'session_provider.dart';
import '../entities/entities.dart';
import '../entities/global/global.dart';
import '../mappers/mappers.dart';
import '../query/api_query.dart';

class ApiProvider extends ApiProviderCore {
  final MapperFactory mapper;

  ApiProvider({
    required super.baseUrl,
    required super.errorHandler,
    required SessionProvider sessionProvider,
    required this.mapper,
  }) : super(
          additionalSetup: (Dio dio) =>
              _additionalProviderSetup(sessionProvider, dio),
        );

  static void _additionalProviderSetup(
    SessionProvider sessionProvider,
    Dio dio,
  ) {
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (
          RequestOptions options,
          RequestInterceptorHandler handler,
        ) async {
          final Session? session = await sessionProvider.getCurrentSession();
          if (session != null) {
            options.headers[HttpHeaders.authorizationHeader] =
                'Bearer ${session.accessToken}';
          }

          return handler.next(options);
        },
      ),
    );
  }

  Future<domain.SmsCodeResult> requestSighUpSmsCode({
    required SmsCodeRequest request,
  }) async {
    return post<SmsVerificationEntity>(
      ApiQuery(
        endpoint: BaseUrlConstants.requestSmsCodeSignUpPath,
        body: request.toJson(),
        params: null,
      ),
      parser: SmsVerificationEntity.fromJson,
    ).then(mapper.smsVerificationMapper.fromEntity);
  }

  Future<domain.SmsCodeResult> requestResetPasswordSmsCode({
    required SmsCodeRequest request,
  }) async {
    return post<SmsVerificationEntity>(
      ApiQuery(
        endpoint: BaseUrlConstants.requestSmsCodeResetPasswordPath,
        body: request.toJson(),
        params: null,
      ),
      parser: SmsVerificationEntity.fromJson,
    ).then(mapper.smsVerificationMapper.fromEntity);
  }

  Future<domain.PhoneVerificationResult> verifyPhoneNumber({
    required VerifyPhoneNumberRequest request,
  }) async {
    return post<PhoneVerificationEntity>(
      ApiQuery(
        endpoint: BaseUrlConstants.verifyPhoneNumberPath,
        params: null,
        body: request.toJson(),
      ),
      parser: PhoneVerificationEntity.fromJson,
    ).then(mapper.phoneVerificationMapper.fromEntity);
  }

  Future<domain.User> signUp({
    required RegisterUserByPhoneRequest request,
  }) async {
    return post<UserEntity>(
      ApiQuery(
        endpoint: BaseUrlConstants.signUpPath,
        params: null,
        body: request.toJson(),
      ),
      parser: UserEntity.fromJson,
    ).then(mapper.userMapper.fromEntity);
  }

  Future<void> recoveryChangePassword({
    required RecoveryChangePasswordRequest request,
  }) async {
    return post<void>(
      ApiQuery(
        endpoint: BaseUrlConstants.recoveryChangePasswordPath,
        body: request.toJson(),
        params: null,
      ),
      parser: (_) {},
    );
  }

  Future<domain.User> getUser() async {
    return get<UserEntity>(
      ApiQuery(
        endpoint: BaseUrlConstants.userPath,
        body: null,
        params: null,
      ),
      parser: UserEntity.fromJson,
    ).then(mapper.userMapper.fromEntity);
  }

  Future<domain.UserBankAccount> fetchUserBalance({
    required FetchUserBalanceRequest request,
  }) async {
    return get<UserBankAccountEntity>(
      ApiQuery(
        endpoint: BaseUrlConstants.userBalancePath,
        body: null,
        params: null,
      ),
      parser: UserBankAccountEntity.fromJson,
    ).then(mapper.userBankAccountMapper.fromEntity);
  }

  Future<domain.UserContacts> fetchUserContacts({
    required FetchUserContactsRequest request,
  }) async {
    return get<UserContactsEntity>(
      ApiQuery(
        endpoint: BaseUrlConstants.userContactsPath,
        id: request.tackId,
        body: null,
        params: null,
      ),
      parser: UserContactsEntity.fromJson,
    ).then(mapper.userContactsMapper.fromEntity);
  }

  Future<domain.User> updateUserInfo({
    required UpdateUserInfoRequest request,
  }) async {
    return patch<UserEntity>(
      ApiQuery(
        endpoint: BaseUrlConstants.userChangeBioPath,
        body: request.toJson(),
        params: null,
      ),
      parser: UserEntity.fromJson,
    ).then(mapper.userMapper.fromEntity);
  }

  Future<Session> changePassword({
    required ChangePasswordRequest request,
  }) async {
    return post<Session>(
      ApiQuery(
        endpoint: BaseUrlConstants.userPasswordChangePath,
        body: request.toJson(),
        params: null,
      ),
      parser: Session.fromJson,
    );
  }

  Future<domain.GroupDetails> fetchGroup({
    required FetchGroupRequest request,
  }) async {
    return get<GroupDetailsEntity>(
      ApiQuery(
        endpoint: BaseUrlConstants.groupPath,
        id: request.id,
        body: null,
        params: null,
      ),
      parser: GroupDetailsEntity.fromJson,
    ).then(mapper.groupDetailsMapper.fromEntity);
  }

  Future<domain.PaginationModel<domain.GroupDetails>> fetchGroups({
    required FetchGroupsRequest request,
  }) async {
    return get<PaginationEntity<GroupDetailsEntity>>(
      ApiQuery(
        endpoint: BaseUrlConstants.groupsMePath,
        body: null,
        params: request.queryParameters,
      ),
      parser: PaginationEntity<GroupDetailsEntity>.fromJson,
    ).then(
      mapper
          .paginationMapper<GroupDetailsEntity, domain.GroupDetails>()
          .fromEntity,
    );
  }

  Future<void> selectGroup({
    required SelectGroupRequest request,
  }) async {
    return post<void>(
      ApiQuery(
        endpoint: BaseUrlConstants.groupSetActivePath,
        id: request.id,
        body: null,
        params: null,
      ),
      parser: (_) {},
      isFormData: true,
    );
  }

  Future<domain.Group> createGroup({
    required CreateGroupRequest request,
  }) async {
    return post<GroupEntity>(
      ApiQuery(
        endpoint: BaseUrlConstants.groupsPath,
        body: request.toJson(),
        params: null,
      ),
      parser: GroupEntity.fromJson,
      isFormData: true,
    ).then(mapper.groupMapper.fromEntity);
  }

  Future<void> leaveGroup({
    required LeaveGroupRequest request,
  }) async {
    return post<void>(
      ApiQuery(
        endpoint: BaseUrlConstants.groupLeavePath,
        id: request.id,
        body: null,
        params: null,
      ),
      parser: (_) {},
    );
  }

  Future<domain.GroupDetails> muteGroup({
    required MuteGroupRequest request,
  }) async {
    return post<GroupDetailsEntity>(
      ApiQuery(
        endpoint: BaseUrlConstants.groupMutePath,
        id: request.id,
        body: null,
        params: null,
      ),
      parser: GroupDetailsEntity.fromJson,
    ).then(mapper.groupDetailsMapper.fromEntity);
  }

  Future<domain.GroupDetails> unMuteGroup({
    required UnMuteGroupRequest request,
  }) async {
    return post<GroupDetailsEntity>(
      ApiQuery(
        endpoint: BaseUrlConstants.groupUnMutePath,
        id: request.id,
        body: null,
        params: null,
      ),
      parser: GroupDetailsEntity.fromJson,
    ).then(mapper.groupDetailsMapper.fromEntity);
  }

  Future<domain.GroupInviteLink> fetchGroupInviteLink({
    required FetchGroupInviteLinkRequest request,
  }) async {
    return get<GroupInviteLinkEntity>(
      ApiQuery(
        endpoint: BaseUrlConstants.groupInviteLinkPath,
        id: request.id,
        body: null,
        params: null,
      ),
      parser: GroupInviteLinkEntity.fromJson,
    ).then(mapper.groupInviteLinkMapper.fromEntity);
  }

  Future<domain.GroupInvite> fetchGroupInvite({
    required FetchGroupInviteRequest request,
  }) async {
    return get<GroupInviteEntity>(
      ApiQuery(
        endpoint: BaseUrlConstants.groupInvitePath,
        body: null,
        params: request.params,
      ),
      parser: GroupInviteEntity.fromJson,
    ).then(mapper.groupInviteMapper.fromEntity);
  }

  Future<domain.PaginationModel<domain.TackUser>> fetchGroupMembers({
    required FetchGroupMembersRequest request,
  }) async {
    return get<PaginationEntity<TackUserEntity>>(
      ApiQuery(
        endpoint: BaseUrlConstants.groupMembersPath,
        id: request.groupId,
        body: null,
        params: request.queryParameters,
      ),
      parser: PaginationEntity<TackUserEntity>.fromJson,
    ).then(
      mapper.paginationMapper<TackUserEntity, domain.TackUser>().fromEntity,
    );
  }

  Future<domain.PaginationModel<domain.GroupInvitation>> fetchGroupInvitations({
    required FetchGroupInvitationsRequest request,
  }) async {
    return get<PaginationEntity<GroupInvitationEntity>>(
      ApiQuery(
        endpoint: BaseUrlConstants.invitationsMePath,
        body: null,
        params: request.queryParameters,
      ),
      parser: PaginationEntity<GroupInvitationEntity>.fromJson,
    ).then(
      mapper
          .paginationMapper<GroupInvitationEntity, domain.GroupInvitation>()
          .fromEntity,
    );
  }

  Future<void> acceptGroupInvitation({
    required AcceptGroupInvitationRequest request,
  }) async {
    return post<void>(
      ApiQuery(
        endpoint: BaseUrlConstants.invitationAcceptPath,
        id: request.id,
        body: null,
        params: null,
      ),
      parser: (_) {},
    );
  }

  Future<void> declineGroupInvitation({
    required DeclineGroupInvitationRequest request,
  }) async {
    return delete(
      ApiQuery(
        endpoint: BaseUrlConstants.invitationDeclinePath,
        id: request.id,
        body: null,
        params: null,
      ),
    );
  }

  Future<List<domain.TemplateTack>> fetchNearbyPopularTacks({
    required FetchNearbyPopularTacksRequest request,
  }) async {
    return get<NearbyPopularTacksResponse>(
      ApiQuery(
        endpoint: BaseUrlConstants.nearbyPopularTacksPath,
        body: null,
        params: null,
      ),
      parser: NearbyPopularTacksResponse.fromJson,
    ).then(
      (NearbyPopularTacksResponse response) =>
          mapper.templateTackMapper.fromList(response.popular),
    );
  }

  Future<List<domain.TemplateTack>> fetchGroupPopularTacks({
    required FetchGroupPopularTacksRequest request,
  }) async {
    return get<GroupPopularTacksResponse>(
      ApiQuery(
        endpoint: BaseUrlConstants.groupPopularTacksPath,
        id: request.groupId,
        body: null,
        params: null,
      ),
      parser: GroupPopularTacksResponse.fromJson,
    ).then(
      (GroupPopularTacksResponse response) =>
          mapper.templateTackMapper.fromList(response.popular),
    );
  }

  Future<bool> fetchHasRunningTack(
    FetchHasRunningTackRequest request,
  ) async {
    return get<HasRunningTackEntity>(
      ApiQuery(
        endpoint: BaseUrlConstants.tackMeHasRunningPath,
        body: null,
        params: null,
      ),
      parser: HasRunningTackEntity.fromJson,
    ).then(
      (HasRunningTackEntity response) => response.hasRunningTack,
    );
  }

  Future<List<domain.RunnerTack>> fetchRunnerTacks(
    FetchRunnerTacksRequest request,
  ) async {
    return get<RunnerTacksResponse>(
      ApiQuery(
        endpoint: BaseUrlConstants.tacksMeRunnerPath,
        body: null,
        params: request.queryParameters,
      ),
      parser: RunnerTacksResponse.fromJson,
    ).then(
      (RunnerTacksResponse response) =>
          mapper.runnerTackMapper.fromList(response.results),
    );
  }

  Future<List<domain.Tack>> fetchTackerTacks(
    FetchTackerTacksRequest request,
  ) async {
    return get<TackerTacksResponse>(
      ApiQuery(
        endpoint: BaseUrlConstants.tacksMeTackerPath,
        body: null,
        params: request.queryParameters,
      ),
      parser: TackerTacksResponse.fromJson,
    ).then(
      (TackerTacksResponse response) =>
          mapper.tackMapper.fromList(response.results),
    );
  }

  Future<domain.PaginationModel<domain.GroupTack>> fetchGroupTacks(
    FetchGroupsTacksRequest request,
  ) async {
    return get<PaginationEntity<GroupTackEntity>>(
      ApiQuery(
        endpoint: BaseUrlConstants.groupsTacksPath,
        id: request.groupId,
        body: null,
        params: request.queryParameters,
      ),
      parser: PaginationEntity<GroupTackEntity>.fromJson,
    ).then(
      mapper.paginationMapper<GroupTackEntity, domain.GroupTack>().fromEntity,
    );
  }

  Future<domain.PaginationModel<domain.Tack>> fetchCompletedTacks(
    FetchCompletedTacksRequest request,
  ) async {
    return get<PaginationEntity<TackEntity>>(
      ApiQuery(
        endpoint: BaseUrlConstants.tacksPreviousMeRunnerPath,
        body: null,
        params: request.queryParameters,
      ),
      parser: PaginationEntity<TackEntity>.fromJson,
    ).then(
      mapper.paginationMapper<TackEntity, domain.Tack>().fromEntity,
    );
  }

  Future<domain.PaginationModel<domain.Tack>> fetchCreatedTacks(
    FetchCreatedTacksRequest request,
  ) async {
    return get<PaginationEntity<TackEntity>>(
      ApiQuery(
        endpoint: BaseUrlConstants.tacksPreviousMeTackerPath,
        body: null,
        params: request.queryParameters,
      ),
      parser: PaginationEntity<TackEntity>.fromJson,
    ).then(
      mapper.paginationMapper<TackEntity, domain.Tack>().fromEntity,
    );
  }

  Future<domain.Tack> createTack(CreateTackRequest request) async {
    return post<TackEntity>(
      ApiQuery(
        endpoint: BaseUrlConstants.tacks,
        body: request.toJson(),
        params: null,
      ),
      parser: TackEntity.fromJson,
    ).then(mapper.tackMapper.fromEntity);
  }

  Future<domain.Tack> updateTack(UpdateTackRequest request) async {
    return put<TackEntity>(
      ApiQuery(
        endpoint: BaseUrlConstants.tacksWithId,
        id: request.id,
        body: request.toJson(),
        params: null,
      ),
      parser: TackEntity.fromJson,
    ).then(mapper.tackMapper.fromEntity);
  }

  Future<void> makeOffer(MakeOfferRequest request) async {
    return post<void>(
      ApiQuery(
        endpoint: BaseUrlConstants.offersPath,
        body: request.toJson(),
        params: null,
      ),
      parser: (_) {},
    );
  }

  Future<void> cancelOffer(CancelOfferRequest request) async {
    return delete(
      ApiQuery(
        endpoint: BaseUrlConstants.offerCancelPath,
        id: request.offerId,
        body: null,
        params: null,
      ),
    );
  }

  Future<void> acceptOffer(AcceptOfferRequest request) async {
    return post<void>(
      ApiQuery(
        endpoint: BaseUrlConstants.offerAcceptPath,
        id: request.offerId,
        body: null,
        params: null,
      ),
      parser: (_) {},
    );
  }

  Future<domain.PaginationModel<domain.Offer>> fetchTackOffers(
    FetchTackOffersRequest request,
  ) async {
    return get<PaginationEntity<OfferEntity>>(
      ApiQuery(
        endpoint: BaseUrlConstants.tackOffersPath,
        id: request.tackId,
        body: null,
        params: request.queryParameters,
      ),
      parser: PaginationEntity<OfferEntity>.fromJson,
    ).then(
      mapper.paginationMapper<OfferEntity, domain.Offer>().fromEntity,
    );
  }

  Future<void> startTackByRunner(StartTackRequest request) async {
    return post<void>(
      ApiQuery(
        endpoint: BaseUrlConstants.tackStartPath,
        id: request.tackId,
        body: null,
        params: null,
      ),
      parser: (_) {},
    );
  }

  Future<void> cancelTackByRunner(CancelTackRequest request) async {
    return post(
      ApiQuery(
        endpoint: BaseUrlConstants.tacksRunnerCancelWithId,
        id: request.tackId,
        body: null,
        params: null,
      ),
      parser: (_) {},
    );
  }

  Future<void> cancelTackByTacker(CancelTackRequest request) async {
    return delete(
      ApiQuery(
        endpoint: BaseUrlConstants.tacksWithId,
        id: request.tackId,
        body: null,
        params: null,
      ),
    );
  }

  Future<void> completeTackByRunner(CompleteTackRequest request) async {
    return post<void>(
      ApiQuery(
        endpoint: BaseUrlConstants.tackCompletePath,
        id: request.tackId,
        body: null,
        params: null,
      ),
      parser: (_) {},
    );
  }

  Future<void> completeTackByTacker(CompleteTackRequest request) async {
    return post<void>(
      ApiQuery(
        endpoint: BaseUrlConstants.tackConfirmCompletePath,
        id: request.tackId,
        body: null,
        params: null,
      ),
      parser: (_) {},
    );
  }

  Future<void> rateTack(RateTackRequest request) async {
    return post<void>(
      ApiQuery(
        endpoint: BaseUrlConstants.reviews,
        body: request.toJson(),
        params: null,
      ),
      parser: (_) {},
    );
  }

  Future<domain.PaymentSetupIntent> fetchSetupIntent({
    required AddCardRequest request,
  }) async {
    return post<PaymentSetupIntentEntity>(
      ApiQuery(
        endpoint: BaseUrlConstants.paymentIntent,
        body: null,
        params: null,
      ),
      parser: PaymentSetupIntentEntity.fromJson,
    ).then(mapper.paymentSetupIntentMapper.fromEntity);
  }

  Future<domain.Plaid> fetchPlaidEntity({
    required AddBankAccountRequest request,
  }) async {
    return get<PlaidEntity>(
      ApiQuery(
        endpoint: BaseUrlConstants.plaidToken,
        body: null,
        params: null,
      ),
      parser: PlaidEntity.fromJson,
    ).then(mapper.plaidMapper.fromEntity);
  }

  Future<List<domain.ConnectedBankAccount>> fetchPlaidBankAccounts({
    required FetchPlaidBankAccountsRequest request,
  }) async {
    return post<FetchConnectedBankAccountsResponse>(
      ApiQuery(
        endpoint: BaseUrlConstants.plaidBankAccounts,
        body: request.toJson(),
        params: null,
      ),
      parser: FetchConnectedBankAccountsResponse.fromJson,
    ).then(
      (FetchConnectedBankAccountsResponse response) =>
          mapper.connectedBankAccountMapper.fromList(
        response.results,
      ),
    );
  }

  Future<List<domain.ConnectedBankAccount>> fetchConnectedBankAccounts({
    required FetchConnectedBankAccountsRequest request,
  }) async {
    return get<FetchConnectedBankAccountsResponse>(
      ApiQuery(
        endpoint: BaseUrlConstants.connectedBankAccounts,
        body: null,
        params: null,
      ),
      parser: FetchConnectedBankAccountsResponse.fromJson,
    ).then(
      (FetchConnectedBankAccountsResponse response) =>
          mapper.connectedBankAccountMapper.fromList(
        response.results,
      ),
    );
  }

  Future<List<domain.ConnectedCard>> fetchConnectedCards({
    required FetchConnectedCardsRequest request,
  }) async {
    return get<FetchConnectedCardsResponse>(
      ApiQuery(
        endpoint: BaseUrlConstants.connectedCards,
        body: null,
        params: null,
      ),
      parser: FetchConnectedCardsResponse.fromJson,
    ).then(
      (FetchConnectedCardsResponse response) =>
          mapper.connectedCardMapper.fromList(
        response.results,
      ),
    );
  }

  Future<void> removePaymentMethod({
    required RemovePaymentMethodRequest request,
  }) async {
    return post<void>(
      ApiQuery(
        endpoint: BaseUrlConstants.removePaymentMethod,
        body: request.toJson(),
        params: null,
      ),
      parser: (_) {},
    );
  }

  Future<void> setPrimaryPaymentMethod({
    required SetPrimaryPaymentMethodRequest request,
  }) async {
    return post<void>(
      ApiQuery(
        endpoint: BaseUrlConstants.setPrimaryPaymentMethod,
        body: request.toJson(),
        params: null,
      ),
      parser: (_) {},
    );
  }

  Future<domain.Fee> fetchFee({
    required FetchFeeRequest request,
  }) async {
    return get<FeeEntity>(
      ApiQuery(
        endpoint: BaseUrlConstants.fetchFees,
        body: null,
        params: null,
      ),
      parser: FeeEntity.fromJson,
    ).then(mapper.feeMapper.fromEntity);
  }

  Future<void> fetchDwollaPaymentIntent({
    required HandleDwollaDepositRequest request,
  }) async {
    return post<void>(
      ApiQuery(
        endpoint: BaseUrlConstants.dwollaDeposit,
        body: request.toJson(),
        params: null,
      ),
      parser: (_) {},
    );
  }

  Future<domain.PaymentSetupIntent> fetchStripePaymentIntent({
    required HandleStripeDepositRequest request,
  }) async {
    return post<PaymentSetupIntentEntity>(
      ApiQuery(
        endpoint: BaseUrlConstants.stripeDeposit,
        body: request.toJson(),
        params: null,
      ),
      parser: PaymentSetupIntentEntity.fromJson,
    ).then(mapper.paymentSetupIntentMapper.fromEntity);
  }

  Future<void> handleDwollaWithdraw({
    required HandleDwollaWithdrawRequest request,
  }) async {
    return post<void>(
      ApiQuery(
        endpoint: BaseUrlConstants.dwollaWithdraw,
        body: request.toJson(),
        params: null,
      ),
      parser: (_) {},
    );
  }

  Future<void> deleteAccount({
    required DeleteAccountRequest request,
  }) async {
    return post<void>(
      ApiQuery(
        endpoint: BaseUrlConstants.userDeleteAccountPath,
        body: request.toJson(),
        params: null,
      ),
      parser: (_) {},
    );
  }
}
