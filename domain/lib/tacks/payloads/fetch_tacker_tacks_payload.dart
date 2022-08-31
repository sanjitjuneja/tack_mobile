part of tacks;

class FetchTackerTacksPayload extends PaginationPayload with EquatableMixin {
  const FetchTackerTacksPayload({
    super.lastObjectId,
    super.nextPage,
  });

  @override
  List<Object?> get props => <Object?>[
    lastObjectId,
    nextPage,
  ];
}
