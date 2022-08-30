part of mappers;

class RunnerTackMapper implements Mapper<RunnerTackEntity, domain.RunnerTack> {
  final TackMapper tackMapper;
  final OfferMapper offerMapper;

  const RunnerTackMapper({
    required this.tackMapper,
    required this.offerMapper,
  });

  @override
  domain.RunnerTack fromEntity(RunnerTackEntity entity) {
    return domain.RunnerTack(
      id: entity.id,
      tack: tackMapper.fromEntity(entity.tack),
      offer:
          entity.offer == null ? null : offerMapper.fromEntity(entity.offer!),
    );
  }

  @override
  RunnerTackEntity toEntity(domain.RunnerTack item) {
    return RunnerTackEntity(
      id: item.id,
      tack: tackMapper.toEntity(item.tack),
      offer: item.offer == null ? null : offerMapper.toEntity(item.offer!),
    );
  }
}
