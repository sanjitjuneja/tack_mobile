part of tacks_entities;

@JsonSerializable()
class GroupPopularTacksResponse extends JsonSerializable {
  final List<TemplateTackEntity> popular;

  const GroupPopularTacksResponse({
    required this.popular,
  });

  factory GroupPopularTacksResponse.fromJson(Map<String, dynamic> json) {
    return _$GroupPopularTacksResponseFromJson(json);
  }

  @override
  Map<String, dynamic> toJson() => _$GroupPopularTacksResponseToJson(this);
}
