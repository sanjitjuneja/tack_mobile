part of mappers;

class OfferTypeMapper implements Mapper<String, domain.OfferType> {
  static const String _offer = 'offer';
  static const String _counterOffer = 'counter_offer';

  @override
  domain.OfferType fromEntity(String entity) {
    switch (entity) {
      case _offer:
        return domain.OfferType.offer;
      case _counterOffer:
        return domain.OfferType.counterOffer;
      default:
        throw Exception('Invalid value');
    }
  }

  @override
  String toEntity(domain.OfferType item) {
    switch (item) {
      case domain.OfferType.offer:
        return _offer;
      case domain.OfferType.counterOffer:
        return _counterOffer;
    }
  }
}
