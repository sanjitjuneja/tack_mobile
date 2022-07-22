part of mappers;

class TackMapper implements Mapper<TackEntity, domain.Tack> {
  final TackStatusMapper tackStatusMapper;
  final TackUserMapper tackUserMapper;

  const TackMapper({
    required this.tackStatusMapper,
    required this.tackUserMapper,
  });

  @override
  domain.Tack fromEntity(TackEntity entity) {
    return domain.Tack(
      id: entity.id,
      title: entity.title,
      price: entity.price,
      description: entity.description,
      estimatedTime: entity.estimationTime,
      allowCounterOffers: entity.allowCounterOffers,
      status: tackStatusMapper.fromEntity(entity.status),
      tacker: tackUserMapper.fromEntity(entity.tacker)!,
      runner: tackUserMapper.fromEntity(entity.runner),
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
      estimationTime: item.estimatedTime,
      allowCounterOffers: item.allowCounterOffers,
      status: tackStatusMapper.toEntity(item.status),
      tacker: tackUserMapper.toEntity(item.tacker)!,
      runner: tackUserMapper.toEntity(item.tacker),
      completionMessage: item.completionMessage,
      completionTime: item.completionTime,
    );
  }
}
