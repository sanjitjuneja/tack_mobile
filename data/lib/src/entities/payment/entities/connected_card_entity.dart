part of payment_entities;

@JsonSerializable(createToJson: false)
class ConnectedCardEntity extends JsonSerializable {
  final String id;
  final String type;
  @JsonKey(name: 'card')
  final ConnectedCardDataEntity cardData;

  const ConnectedCardEntity({
    required this.id,
    required this.type,
    required this.cardData,
  });

  factory ConnectedCardEntity.fromJson(Map<String, dynamic> json) {
    return _$ConnectedCardEntityFromJson(json);
  }
}
