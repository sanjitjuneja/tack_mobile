part of tacks_entities;

class GetTackOffersRequest extends JsonSerializable {
  final int tackId;

  const GetTackOffersRequest({
    required this.tackId,
  });
}
