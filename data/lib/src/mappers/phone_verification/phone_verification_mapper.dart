part of mappers;

class PhoneVerificationMapper
    implements Mapper<PhoneVerificationEntity, domain.PhoneVerificationResult> {
  @override
  domain.PhoneVerificationResult fromEntity(PhoneVerificationEntity entity) {
    return domain.PhoneVerificationResult(
      message: entity.message,
    );
  }

  @override
  PhoneVerificationEntity toEntity(domain.PhoneVerificationResult item) {
    return PhoneVerificationEntity(
      message: item.message,
    );
  }
}
