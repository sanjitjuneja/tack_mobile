part of tacks_entities;

@JsonSerializable(createToJson: false)
class TackerTacksResponse extends JsonSerializable {
  final List<TemplateTackEntity> results;

  const TackerTacksResponse({
    required this.results,
  });

  factory TackerTacksResponse.fromJson(Map<String, dynamic> json) {
    return _$TackerTacksResponseFromJson(json);
  }
}
