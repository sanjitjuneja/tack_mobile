part of tacks_entities;

@JsonSerializable()
@BooleanConverter()
@DurationConverter()
class TemplateTackEntity extends JsonSerializable with ListParserMixin {
  final String title;
  final int price;
  final String description;
  @JsonKey(name: 'estimation_time_seconds')
  final Duration estimationTime;
  @JsonKey(name: 'allow_counter_offer')
  final bool allowCounterOffer;

  const TemplateTackEntity({
    required this.title,
    required this.price,
    required this.description,
    required this.estimationTime,
    required this.allowCounterOffer,
  });

  factory TemplateTackEntity.fromJson(Map<String, dynamic> json) {
    return _$TemplateTackEntityFromJson(json);
  }

  static List<TemplateTackEntity> listFromJson(Map<String, dynamic> json) =>
      ListParserMixin.listFromJson(json, TemplateTackEntity.fromJson);

  @override
  Map<String, dynamic> toJson() => _$TemplateTackEntityToJson(this);
}
