part of tacks_entities;

@JsonSerializable()
class GroupTacksResponse extends JsonSerializable {
  final int count;
  final String? previous;
  final String? next;
  final List<TackEntity> results;

  const GroupTacksResponse({
    required this.count,
    required this.previous,
    required this.next,
    required this.results,
  });

  factory GroupTacksResponse.fromJson(Map<String, dynamic> json) {
    return _$GroupTacksResponseFromJson(json);
  }

  @override
  Map<String, dynamic> toJson() => _$GroupTacksResponseToJson(this);

}
