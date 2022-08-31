part of tacks_entities;

@JsonSerializable()
class RunnerTackEntity extends JsonSerializable {
  final int id;
  final TackEntity tack;
  final OfferEntity? offer;

  const RunnerTackEntity({
    required this.id,
    required this.tack,
    required this.offer,
  });

  factory RunnerTackEntity.fromJson(Map<String, dynamic> json) {
    return _$RunnerTackEntityFromJson(json);
  }

  @override
  Map<String, dynamic> toJson() => _$RunnerTackEntityToJson(this);
}
