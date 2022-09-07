part of mappers;

class FeeDataMapper implements Mapper<FeeDataEntity, domain.FeeData> {
  const FeeDataMapper();

  @override
  domain.FeeData fromEntity(FeeDataEntity entity) {
    return domain.FeeData(
      feePercent: entity.feePercent,
      feeMin: entity.feeMin,
      feeMax: entity.feeMax,
    );
  }

  @override
  FeeDataEntity toEntity(domain.FeeData item) {
    return FeeDataEntity(
      feePercent: item.feePercent,
      feeMin: item.feeMin,
      feeMax: item.feeMax,
    );
  }
}
