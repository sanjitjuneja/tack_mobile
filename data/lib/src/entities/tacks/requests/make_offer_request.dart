part of tacks_entities;

@JsonSerializable(createFactory: false)
class MakeOfferRequest extends JsonSerializable {
  final int tack;
  final int? price;

  const MakeOfferRequest({
    required this.tack,
    required this.price,
  });

  @override
  Map<String, dynamic> toJson() => _$MakeOfferRequestToJson(this);
}
