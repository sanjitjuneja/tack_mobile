part of mappers;

class TemplateTackMapper
    implements Mapper<TemplateTackEntity, domain.TemplateTack> {
  const TemplateTackMapper();

  @override
  domain.TemplateTack fromEntity(TemplateTackEntity entity) {
    return domain.TemplateTack(
      title: entity.title,
      price: entity.price / 100,
      description: entity.description,
      estimatedTime: entity.estimationTime,
      allowCounterOffers: entity.allowCounterOffer,
    );
  }

  @override
  TemplateTackEntity toEntity(domain.TemplateTack item) {
    return TemplateTackEntity(
      title: item.title,
      price: (item.price * 100).toInt(),
      description: item.description,
      estimationTime: item.estimatedTime,
      allowCounterOffer: item.allowCounterOffers,
    );
  }
}
