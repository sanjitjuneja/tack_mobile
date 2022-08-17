part of tacks;

class CancelOfferPayload extends Equatable {
  final Offer offer;

  const CancelOfferPayload({
    required this.offer,
  });

  @override
  List<Object> get props => <Object>[
    offer,
  ];
}
