part of mappers;

class MapperFactory {
  GroupMapper get groupMapper => const GroupMapper();

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

  CustomerMapper get customerMapper => CustomerMapper();

  SmsVerificationMapper get smsVerificationMapper => SmsVerificationMapper();

  PhoneVerificationMapper get phoneVerificationMapper =>
      PhoneVerificationMapper();
}
