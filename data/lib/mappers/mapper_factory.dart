part of mappers;

class MapperFactory {
  GroupMapper get groupMapper => GroupMapper();

  CustomerMapper get customerMapper => CustomerMapper();

  MessageMapper get messageMapper => MessageMapper();

  TackStatusMapper get tackStatusMapper => TackStatusMapper();

  TackMapper get tackMapper => TackMapper(tackStatusMapper: tackStatusMapper);

  SmsVerificationMapper get smsVerificationMapper => SmsVerificationMapper();

  PhoneVerificationMapper get phoneVerificationMapper =>
      PhoneVerificationMapper();
}
