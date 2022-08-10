part of tacks_entities;

@JsonSerializable()
class GroupOffersResponse extends JsonSerializable {
  final int count;
  final String? previous;
  final String? next;
  final List<OfferEntity> results;

  const GroupOffersResponse({
    required this.count,
    required this.previous,
    required this.next,
    required this.results,
  });

  factory GroupOffersResponse.fromJson(Map<String, dynamic> json) {
    return _$GroupOffersResponseFromJson(json);
  }

  @override
  Map<String, dynamic> toJson() => _$GroupOffersResponseToJson(this);

}
