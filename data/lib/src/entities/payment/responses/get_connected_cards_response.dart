part of payment_entities;

@JsonSerializable()
class GetConnectedCardsResponse extends JsonSerializable {
  final List<ConnectedCardEntity> results;

  const GetConnectedCardsResponse({
    required this.results,
  });

  factory GetConnectedCardsResponse.fromJson(Map<String, dynamic> json) {
    return _$GetConnectedCardsResponseFromJson(json);
  }

  @override
  Map<String, dynamic> toJson() =>
      _$GetConnectedCardsResponseToJson(this);
}