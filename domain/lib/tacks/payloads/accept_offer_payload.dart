part of tacks;

class AcceptOfferPayload extends Equatable {
  final Offer offer;
  final PaymentDetails paymentDetails;

  const AcceptOfferPayload({
    required this.offer,
    required this.paymentDetails,
  });

  @override
  List<Object?> get props => <Object?>[
        offer,
        paymentDetails,
      ];
}
