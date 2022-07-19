part of mappers;

class TackMapper implements Mapper<TackEntity, domain.Tack> {
  final TackStatusMapper tackStatusMapper;

  const TackMapper({
    required this.tackStatusMapper,
  });

  @override
  domain.Tack fromEntity(TackEntity entity) {
    return domain.Tack(
      id: entity.id,
      title: entity.title,
      price: entity.price,
      description: entity.description,
      createdAt: entity.createdTime,
      expiresAt: entity.expirationTime,
      allowCounterOffers: entity.allowCounterOffers,
      status: tackStatusMapper.fromEntity(entity.status),
      tacker: entity.tacker,
      runner: entity.runner,
      completionMessage: entity.completionMessage,
      completionTime: entity.completionTime,
    );
  }

  @override
  TackEntity toEntity(domain.Tack item) {
    return TackEntity(
      id: item.id,
      title: item.title,
      price: item.price,
      description: item.description,
      createdTime: item.createdAt,
      expirationTime: item.expiresAt,
      allowCounterOffers: item.allowCounterOffers,
      status: tackStatusMapper.toEntity(item.status),
      tacker: item.tacker,
      runner: item.runner,
      completionMessage: item.completionMessage,
      completionTime: item.completionTime,
    );
  }
}
