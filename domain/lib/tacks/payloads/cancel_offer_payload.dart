part of tacks;

class CancelOfferPayload extends Equatable {
  final Tack tack;

  const CancelOfferPayload({
    required this.tack,
  });

  @override
  List<Object> get props => <Object>[
    tack,
  ];
}
