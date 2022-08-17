part of tacks_entities;

class AcceptOfferRequest extends JsonSerializable {
  final int offerId;

  const AcceptOfferRequest({
    required this.offerId,
  });
}
