part of payment_entities;

@JsonSerializable()
class FetchConnectedCardsResponse extends JsonSerializable {
  final List<ConnectedCardEntity> results;

  const FetchConnectedCardsResponse({
    required this.results,
  });

  factory FetchConnectedCardsResponse.fromJson(Map<String, dynamic> json) {
    return _$FetchConnectedCardsResponseFromJson(json);
  }

  @override
  Map<String, dynamic> toJson() => _$FetchConnectedCardsResponseToJson(this);
}
