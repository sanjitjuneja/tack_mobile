part of mappers;

class FeeMapper implements Mapper<FeeEntity, domain.Fee> {
  final FeeDataMapper feeDataMapper;

  const FeeMapper({
    required this.feeDataMapper,
  });

  @override
  domain.Fee fromEntity(FeeEntity entity) {
    return domain.Fee(
      stripeFeeData: feeDataMapper.fromEntity(entity.stripeFeeData),
      dwollaFeeData: feeDataMapper.fromEntity(entity.dwollaFeeData),
    );
  }

  @override
  FeeEntity toEntity(domain.Fee item) {
    return FeeEntity(
      stripeFeeData: feeDataMapper.toEntity(item.stripeFeeData),
      dwollaFeeData: feeDataMapper.toEntity(item.dwollaFeeData),
    );
  }
}
