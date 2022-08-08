part of tacks_entities;

@JsonSerializable()
class NearbyPopularTacksResponse extends JsonSerializable {
  final List<TemplateTackEntity> popular;

  const NearbyPopularTacksResponse({
    required this.popular,
  });

  factory NearbyPopularTacksResponse.fromJson(Map<String, dynamic> json) {
    return _$NearbyPopularTacksResponseFromJson(json);
  }

  @override
  Map<String, dynamic> toJson() => _$NearbyPopularTacksResponseToJson(this);
}
