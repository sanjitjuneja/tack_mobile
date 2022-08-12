part of tacks_entities;

@JsonSerializable()
class TackOffersResponse extends JsonSerializable {
  final int count;
  final String? previous;
  final String? next;
  final List<OfferEntity> results;

  const TackOffersResponse({
    required this.count,
    required this.previous,
    required this.next,
    required this.results,
  });

  factory TackOffersResponse.fromJson(Map<String, dynamic> json) {
    return _$TackOffersResponseFromJson(json);
  }

  @override
  Map<String, dynamic> toJson() => _$TackOffersResponseToJson(this);

}
