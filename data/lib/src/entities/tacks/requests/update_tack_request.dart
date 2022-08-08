part of tacks_entities;

@JsonSerializable(createFactory: false)
class UpdateTackRequest extends JsonSerializable {
  @JsonKey(ignore: true)
  final int id;
  final String title;
  final int price;
  final String description;
  @JsonKey(name: 'estimation_time_seconds')
  final int estimationTimeSeconds;
  @JsonKey(name: 'allow_counter_offer')
  final bool allowCounterOffer;
  final String type;

  const UpdateTackRequest({
    required this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.estimationTimeSeconds,
    required this.allowCounterOffer,
    this.type = 'groups'
  });


  @override
  Map<String, dynamic> toJson() => _$UpdateTackRequestToJson(this);
}
