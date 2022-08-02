part of tacks_entities;

@JsonSerializable()
@DoubleConverter()
@BooleanConverter()
class TackEntity extends JsonSerializable with ListParserMixin {
  final int id;
  final String title;
  final double price;
  final String description;
  @JsonKey(name: 'estimation_time_seconds')
  final Duration estimationTime;
  @JsonKey(name: 'allow_counter_offers')
  final bool allowCounterOffers;
  final String status;
  final TackUserEntity tacker;
  final TackUserEntity? runner;
  final GroupEntity group;
  @JsonKey(name: 'completion_message')
  final String? completionMessage;
  @JsonKey(name: 'completion_time')
  final DateTime? completionTime;

  const TackEntity({
    required this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.estimationTime,
    required this.allowCounterOffers,
    required this.status,
    required this.tacker,
    required this.runner,
    required this.group,
    required this.completionMessage,
    required this.completionTime,
  });

  factory TackEntity.fromJson(Map<String, dynamic> json) {
    return _$TackEntityFromJson(json);
  }

  static List<TackEntity> listFromJson(Map<String, dynamic> json) =>
      ListParserMixin.listFromJson(json, TackEntity.fromJson);

  @override
  Map<String, dynamic> toJson() => _$TackEntityToJson(this);
}
