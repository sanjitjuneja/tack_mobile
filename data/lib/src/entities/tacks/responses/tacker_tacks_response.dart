part of tacks_entities;

@JsonSerializable()
class TackerTacksResponse extends JsonSerializable {
  final int count;
  final String? previous;
  final String? next;
  final List<TackEntity> results;

  const TackerTacksResponse({
    required this.count,
    required this.previous,
    required this.next,
    required this.results,
  });

  factory TackerTacksResponse.fromJson(Map<String, dynamic> json) {
    return _$TackerTacksResponseFromJson(json);
  }

  @override
  Map<String, dynamic> toJson() => _$TackerTacksResponseToJson(this);

}
