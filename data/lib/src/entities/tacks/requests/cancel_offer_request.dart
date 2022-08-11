part of tacks_entities;

class CancelOfferRequest extends JsonSerializable {
  final int tackId;

  const CancelOfferRequest({
    required this.tackId,
  });
}
