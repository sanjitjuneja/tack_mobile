part of mappers;

class TackMapper implements Mapper<TackEntity, domain.Tack> {
  final TackStatusMapper tackStatusMapper;
  final TackUserMapper tackUserMapper;
  final GroupMapper groupMapper;

  const TackMapper({
    required this.tackStatusMapper,
    required this.tackUserMapper,
    required this.groupMapper,
  });

  @override
  domain.Tack fromEntity(TackEntity entity) {
    return domain.Tack(
      id: entity.id,
      title: entity.title,
      price: entity.price / 100,
      description: entity.description,
      estimatedTime: entity.estimationTime,
      allowCounterOffers: entity.allowCounterOffer,
      status: tackStatusMapper.fromEntity(entity.status),
      tacker: tackUserMapper.fromEntity(entity.tacker),
      runner: entity.runner != null
          ? tackUserMapper.fromEntity(entity.runner!)
          : null,
      group: groupMapper.fromEntity(entity.group),
      completionMessage: entity.completionMessage,
      completionTime: entity.completionTime,
    );
  }

  @override
  TackEntity toEntity(domain.Tack item) {
    return TackEntity(
      id: item.id,
      title: item.title,
      price: (item.price * 100).toInt(),
      description: item.description,
      estimationTime: item.estimatedTime,
      allowCounterOffer: item.allowCounterOffers,
      status: tackStatusMapper.toEntity(item.status),
      tacker: tackUserMapper.toEntity(item.tacker),
      runner:
          item.runner != null ? tackUserMapper.toEntity(item.runner!) : null,
      group: groupMapper.toEntity(item.group),
      completionMessage: item.completionMessage,
      completionTime: item.completionTime,
    );
  }
}
