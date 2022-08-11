part of tacks;

class TackOffersPayload extends Equatable {
  final Tack tack;

  const TackOffersPayload({
    required this.tack,
  });

  @override
  List<Object> get props => <Object>[
    tack,
  ];
}
