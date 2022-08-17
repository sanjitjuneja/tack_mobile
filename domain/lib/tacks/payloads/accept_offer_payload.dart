part of tacks;

class AcceptOfferPayload extends Equatable {
  final Offer offer;

  const AcceptOfferPayload({
    required this.offer,
  });

  @override
  List<Object> get props => <Object>[
    offer,
  ];
}
