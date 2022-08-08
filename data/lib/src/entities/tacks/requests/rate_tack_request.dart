part of tacks_entities;

@JsonSerializable(createFactory: false)
class RateTackRequest extends JsonSerializable {
  final int tack;
  final String description;
  final int rating;

  const RateTackRequest({
    required this.tack,
    required this.description,
    required this.rating,
  });

  @override
  Map<String, dynamic> toJson() => _$RateTackRequestToJson(this);
}
