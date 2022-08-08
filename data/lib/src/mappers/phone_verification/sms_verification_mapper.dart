part of mappers;

class SmsVerificationMapper
    implements Mapper<SmsVerificationEntity, domain.SmsCodeResult> {
  @override
  domain.SmsCodeResult fromEntity(SmsVerificationEntity entity) {
    return domain.SmsCodeResult(uuid: entity.uuid);
  }

  @override
  SmsVerificationEntity toEntity(domain.SmsCodeResult item) {
    return SmsVerificationEntity(uuid: item.uuid);
  }
}
