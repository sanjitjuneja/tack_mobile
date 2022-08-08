part of tacks_entities;

@JsonSerializable()
class RunnerTacksResponse extends JsonSerializable {
  final int count;
  final String? previous;
  final String? next;
  final List<RunnerTackEntity> results;

  const RunnerTacksResponse({
    required this.count,
    required this.previous,
    required this.next,
    required this.results,
  });

  factory RunnerTacksResponse.fromJson(Map<String, dynamic> json) {
    return _$RunnerTacksResponseFromJson(json);
  }

  @override
  Map<String, dynamic> toJson() => _$RunnerTacksResponseToJson(this);

}
