part of mappers;

class ConnectedCardDataMapper
    implements Mapper<ConnectedCardDataEntity, domain.ConnectedCardData> {
  const ConnectedCardDataMapper();

  @override
  domain.ConnectedCardData fromEntity(ConnectedCardDataEntity entity) {
    return domain.ConnectedCardData(
      brand: entity.brand,
      last4: entity.last4,
      expYear: entity.expYear,
      expMonth: entity.expMonth,
      imageUrl: entity.imageUrl,
    );
  }

  @override
  ConnectedCardDataEntity toEntity(domain.ConnectedCardData item) {
    return ConnectedCardDataEntity(
      brand: item.brand,
      last4: item.last4,
      expYear: item.expYear,
      expMonth: item.expMonth,
      imageUrl: item.imageUrl,
    );
  }
}
