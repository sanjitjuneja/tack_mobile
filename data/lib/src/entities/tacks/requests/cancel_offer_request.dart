part of tacks_entities;

class CancelOfferRequest extends JsonSerializable {
  final int offerId;

  const CancelOfferRequest({
    required this.offerId,
  });
}
