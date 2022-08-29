import 'dart:io';

import 'package:data/src/entities/entities.dart';
import 'package:data/src/entities/global/global.dart';
import 'package:data/src/mappers/mappers.dart';
import 'package:data/src/providers/api_provider_core.dart';
import 'package:data/src/providers/session_provider.dart';
import 'package:data/src/query/api_query.dart';
import 'package:dio/dio.dart';
import 'package:domain/domain.dart' as domain;

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
    ).then(mapper.customerMapper.fromEntity);
  }

  Future<domain.User> getUser() async {
    return get<UserEntity>(
      ApiQuery(endpoint: BaseUrlConstants.userPath, body: null, params: null),
      parser: UserEntity.fromJson,
    ).then(mapper.customerMapper.fromEntity);
  }

  Future<domain.Group> getGroup({
    required GetGroupRequest request,
  }) async {
    return get<GroupEntity>(
      ApiQuery(
        endpoint: BaseUrlConstants.groupPath,
        id: request.id,
        body: null,
        params: null,
      ),
      parser: GroupEntity.fromJson,
    ).then(mapper.groupMapper.fromEntity);
  }

  Future<List<domain.Group>> getGroups({
    required GetGroupsRequest request,
  }) async {
    return get<GetGroupsResponse>(
      ApiQuery(
        endpoint: BaseUrlConstants.groupsMePath,
        body: null,
        params: null,
      ),
      parser: GetGroupsResponse.fromJson,
    ).then(
      (GetGroupsResponse response) =>
          mapper.groupMapper.fromList(response.results),
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

  Future<domain.Group> muteGroup({
    required MuteGroupRequest request,
  }) async {
    return post<GroupEntity>(
      ApiQuery(
        endpoint: BaseUrlConstants.groupMutePath,
        id: request.id,
        body: null,
        params: null,
      ),
      parser: GroupEntity.fromJson,
    ).then(mapper.groupMapper.fromEntity);
  }

  Future<domain.Group> unMuteGroup({
    required UnMuteGroupRequest request,
  }) async {
    return post<GroupEntity>(
      ApiQuery(
        endpoint: BaseUrlConstants.groupUnMutePath,
        id: request.id,
        body: null,
        params: null,
      ),
      parser: GroupEntity.fromJson,
    ).then(mapper.groupMapper.fromEntity);
  }

  Future<domain.GroupInviteLink> getGroupInviteLink({
    required GetGroupInviteLinkRequest request,
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

  Future<domain.GroupInvite> getGroupInvite({
    required GetGroupInviteRequest request,
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

  Future<List<domain.TackUser>> getGroupMembers({
    required GetGroupMembersRequest request,
  }) async {
    return get<GetGroupMembersResponse>(
      ApiQuery(
        endpoint: BaseUrlConstants.groupMembersPath,
        id: request.id,
        body: null,
        params: null,
      ),
      parser: GetGroupMembersResponse.fromJson,
    ).then(
      (GetGroupMembersResponse response) {
        return List<domain.TackUser>.from(
          mapper.tackUserMapper.fromList(response.results),
        );
      },
    );
  }

  Future<List<domain.GroupInvitation>> getInvitations({
    required GetGroupInvitationsRequest request,
  }) async {
    return get<GetGroupInvitationsResponse>(
      ApiQuery(
        endpoint: BaseUrlConstants.invitationsMePath,
        body: null,
        params: null,
      ),
      parser: GetGroupInvitationsResponse.fromJson,
    ).then(
      (GetGroupInvitationsResponse response) =>
          mapper.groupInvitationMapper.fromList(response.results),
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

  Future<List<domain.TemplateTack>> getNearbyPopularTacks({
    required NearbyPopularTacksRequest request,
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

  Future<List<domain.TemplateTack>> getGroupPopularTacks({
    required GroupPopularTacksRequest request,
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

  Future<List<domain.RunnerTack>> getRunnerTacks() async {
    return get<RunnerTacksResponse>(
      ApiQuery(
        endpoint: BaseUrlConstants.tacksMeRunnerPath,
        body: null,
        params: null,
      ),
      parser: RunnerTacksResponse.fromJson,
    ).then(
      (RunnerTacksResponse response) =>
          mapper.runnerTackMapper.fromList(response.results),
    );
  }

  Future<List<domain.Tack>> getTackerTacks() async {
    return get<TackerTacksResponse>(
      ApiQuery(
        endpoint: BaseUrlConstants.tacksMeTackerPath,
        body: null,
        params: null,
      ),
      parser: TackerTacksResponse.fromJson,
    ).then(
      (TackerTacksResponse response) =>
          mapper.tackMapper.fromList(response.results),
    );
  }

  Future<domain.PaginationModel<domain.Tack>> getGroupTacks(
    GroupTacksRequest request,
  ) async {
    return get<PaginationEntity<TackEntity>>(
      ApiQuery(
        endpoint: BaseUrlConstants.groupsTacksPath,
        id: request.groupId,
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
        endpoint: BaseUrlConstants.offerTestAcceptPath,
        id: request.offerId,
        body: null,
        params: null,
      ),
      parser: (_) {},
    );
  }

  Future<domain.PaginationModel<domain.Offer>> getTackOffers(
    GetTackOffersRequest request,
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

// Future<void> logOut() {
//   return get<void>(
//     ApiQuery(
//       endpointPostfix: BaseUrlConstants.logOutPath,
//       body: null,
//       params: null,
//     ),
//     parser: (_) {},
//   );
// }
}
