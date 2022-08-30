part of mappers;

class MapperFactory {
  GroupMapper get groupMapper => const GroupMapper();

  GroupDetailsMapper get groupDetailsMapper => GroupDetailsMapper(
        groupMapper: groupMapper,
      );

  GroupInviteLinkMapper get groupInviteLinkMapper =>
      const GroupInviteLinkMapper();

  GroupInvitationMapper get groupInvitationMapper => GroupInvitationMapper(
        groupMapper: groupMapper,
      );

  GroupInviteMapper get groupInviteMapper => GroupInviteMapper(
        groupDetailsMapper: groupDetailsMapper,
        groupInvitationMapper: groupInvitationMapper,
      );

  TemplateTackMapper get templateTackMapper => const TemplateTackMapper();

  TackStatusMapper get tackStatusMapper => const TackStatusMapper();

  TackUserContactsMapper get tackUserContactsMapper =>
      const TackUserContactsMapper();

  TackUserMapper get tackUserMapper => TackUserMapper(
        tackUserContactsMapper: tackUserContactsMapper,
      );

  TackMapper get tackMapper => TackMapper(
        tackStatusMapper: tackStatusMapper,
        tackUserMapper: tackUserMapper,
        groupMapper: groupMapper,
      );

  GroupTackMapper get groupTackMapper => GroupTackMapper(
        tackMapper: tackMapper,
      );

  OfferTypeMapper get offerTypeMapper => OfferTypeMapper();

  OfferMapper get offerMapper => OfferMapper(
        offerTypeMapper: offerTypeMapper,
        tackUserMapper: tackUserMapper,
      );

  RunnerTackMapper get runnerTackMapper => RunnerTackMapper(
        tackMapper: tackMapper,
        offerMapper: offerMapper,
      );

  UserContactsMapper get userContactsMapper => const UserContactsMapper();

  UserBankAccountMapper get userBankAccountMapper =>
      const UserBankAccountMapper();

  UserMapper get userMapper => UserMapper(
        userBankAccountMapper: userBankAccountMapper,
      );

  PlaidMapper get plaidMapper => const PlaidMapper();

  ConnectedBankAccountMapper get connectedBankAccountMapper =>
      const ConnectedBankAccountMapper();

  PaymentSetupIntentMapper get paymentSetupIntentMapper =>
      const PaymentSetupIntentMapper();

  SmsVerificationMapper get smsVerificationMapper => SmsVerificationMapper();

  PhoneVerificationMapper get phoneVerificationMapper =>
      PhoneVerificationMapper();

  PaginationMapper<S, C> paginationMapper<S, C>() => PaginationMapper<S, C>(
        mapper: _factory<S, C>(),
      );

  Mapper<S, C> _factory<S, C>() {
    if (S == GroupDetailsEntity) {
      return groupDetailsMapper as Mapper<S, C>;
    }

    if (S == GroupInvitationEntity) {
      return groupInvitationMapper as Mapper<S, C>;
    }

    if (S == TackEntity) {
      return tackMapper as Mapper<S, C>;
    }

    if (S == GroupTackEntity) {
      return groupTackMapper as Mapper<S, C>;
    }

    if (S == RunnerTackEntity) {
      return runnerTackMapper as Mapper<S, C>;
    }

    if (S == OfferEntity) {
      return offerMapper as Mapper<S, C>;
    }

    if (S == TackUserEntity) {
      return tackUserMapper as Mapper<S, C>;
    }

    throw Exception('wrong type');
  }
}
