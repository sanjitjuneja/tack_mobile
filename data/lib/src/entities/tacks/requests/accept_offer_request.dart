part of tacks_entities;

@JsonSerializable(
  createFactory: false,
  includeIfNull: false,
)
class AcceptOfferRequest extends JsonSerializable {
  @JsonKey(ignore: true)
  final int offerId;
  @JsonKey(name: 'payment_info')
  final PaymentDetailsEntity paymentInfo;

  const AcceptOfferRequest({
    required this.offerId,
    required this.paymentInfo,
  });

  @override
  Map<String, dynamic> toJson() => _$AcceptOfferRequestToJson(this);
}
