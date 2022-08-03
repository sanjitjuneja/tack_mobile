part of tacks_entities;

@JsonSerializable()
@DoubleConverter()
@BooleanConverter()
@DateTimeConverter()
class OfferEntity extends JsonSerializable {
  final int id;
  final int tack;
  final double? price;
  final String offerType;
  @JsonKey(name: 'is_accepted')
  final bool isAccepted;
  final TackUserEntity runner;
  @JsonKey(name: 'creation_time')
  final DateTime creationTime;
  @JsonKey(name: 'lifetime_seconds')
  final Duration lifeTime;

  const OfferEntity({
    required this.id,
    required this.tack,
    required this.price,
    required this.offerType,
    required this.isAccepted,
    required this.runner,
    required this.creationTime,
    required this.lifeTime,
  });

  factory OfferEntity.fromJson(Map<String, dynamic> json) {
    return _$OfferEntityFromJson(json);
  }

  @override
  Map<String, dynamic> toJson() => _$OfferEntityToJson(this);
}
