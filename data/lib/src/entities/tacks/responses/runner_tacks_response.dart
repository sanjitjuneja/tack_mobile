part of tacks_entities;

@JsonSerializable(createToJson: false)
class RunnerTacksResponse extends JsonSerializable {
  final List<RunnerTackEntity> results;

  const RunnerTacksResponse({
    required this.results,
  });

  factory RunnerTacksResponse.fromJson(Map<String, dynamic> json) {
    return _$RunnerTacksResponseFromJson(json);
  }
}
