part of tacks_entities;

@JsonSerializable()
class GroupTackEntity extends JsonSerializable {
  final int id;
  final TackEntity tack;
  @JsonKey(name: 'is_mine_offer_sent')
  final bool isMineOfferSent;

  const GroupTackEntity({
    required this.id,
    required this.tack,
    required this.isMineOfferSent,
  });

  factory GroupTackEntity.fromJson(Map<String, dynamic> json) {
    return _$GroupTackEntityFromJson(json);
  }

  @override
  Map<String, dynamic> toJson() => _$GroupTackEntityToJson(this);
}
