part of tacks;

class FetchTackOffersPayload extends PaginationPayload with EquatableMixin {
  final Tack tack;

  const FetchTackOffersPayload({
    required this.tack,
    super.lastObjectId,
    super.nextPage,
  });

  @override
  List<Object?> get props => <Object?>[
        tack,
        lastObjectId,
        nextPage,
      ];
}
