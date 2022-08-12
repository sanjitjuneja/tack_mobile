part of tacks;

class TackOffersPayload extends Equatable {
  final Tack tack;
  final Uri? nextPage;

  const TackOffersPayload({
    required this.tack,
    this.nextPage,
  });

  @override
  List<Object?> get props => <Object?>[
        tack,
        nextPage,
      ];
}
