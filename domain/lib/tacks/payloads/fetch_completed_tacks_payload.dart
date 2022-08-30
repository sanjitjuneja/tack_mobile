part of tacks;

class FetchCompletedTacksPayload extends PaginationPayload with EquatableMixin {
  const FetchCompletedTacksPayload({
    super.lastObjectId,
    super.nextPage,
  });

  @override
  List<Object?> get props => <Object?>[
    lastObjectId,
    nextPage,
  ];
}