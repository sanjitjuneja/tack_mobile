part of mappers;

class ConnectedCardMapper
    implements Mapper<ConnectedCardEntity, domain.ConnectedCard> {
  final ConnectedCardDataMapper connectedCardDataMapper;

  const ConnectedCardMapper({
    required this.connectedCardDataMapper,
  });

  @override
  domain.ConnectedCard fromEntity(ConnectedCardEntity entity) {
    return domain.ConnectedCard(
      id: entity.id,
      type: entity.type,
      cardData: connectedCardDataMapper.fromEntity(entity.cardData),
    );
  }

  @override
  ConnectedCardEntity toEntity(domain.ConnectedCard item) {
    return ConnectedCardEntity(
      id: item.id,
      type: item.type,
      cardData: connectedCardDataMapper.toEntity(item.cardData),
    );
  }
}
