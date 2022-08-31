part of mappers;

class OfferMapper extends Mapper<OfferEntity, domain.Offer> {
  final OfferTypeMapper offerTypeMapper;
  final TackUserMapper tackUserMapper;

  const OfferMapper({
    required this.offerTypeMapper,
    required this.tackUserMapper,
  });

  @override
  domain.Offer fromEntity(OfferEntity entity) {
    return domain.Offer(
      id: entity.id,
      tackId: entity.tack,
      runner: tackUserMapper.fromEntity(entity.runner),
      price: entity.price != null ? entity.price! / 100 : null,
      type: offerTypeMapper.fromEntity(entity.offerType),
      isAccepted: entity.isAccepted,
      createdAt: entity.creationTime,
      lifetime: entity.lifeTime,
    );
  }

  @override
  OfferEntity toEntity(domain.Offer item) {
    return OfferEntity(
      id: item.id,
      tack: item.tackId,
      runner: tackUserMapper.toEntity(item.runner),
      price: item.price != null ? (item.price! * 100).toInt() : null,
      offerType: offerTypeMapper.toEntity(item.type),
      isAccepted: item.isAccepted,
      creationTime: item.createdAt,
      lifeTime: item.lifetime,
    );
  }
}
