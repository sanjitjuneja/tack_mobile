part of tacks_entities;

@JsonSerializable(createToJson: false)
class TackerTacksResponse extends JsonSerializable {
  final List<TackEntity> results;

  const TackerTacksResponse({
    required this.results,
  });

  factory TackerTacksResponse.fromJson(Map<String, dynamic> json) {
    return _$TackerTacksResponseFromJson(json);
  }
}
