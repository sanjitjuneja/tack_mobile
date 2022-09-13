part of tacks_entities;

@JsonSerializable(createToJson: false)
class NearbyPopularTacksResponse extends JsonSerializable {
  final List<TemplateTackEntity> popular;

  const NearbyPopularTacksResponse({
    required this.popular,
  });

  factory NearbyPopularTacksResponse.fromJson(Map<String, dynamic> json) {
    return _$NearbyPopularTacksResponseFromJson(json);
  }
}
