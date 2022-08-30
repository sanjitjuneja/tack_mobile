part of tacks;

class FetchCreatedTacksPayload extends PaginationPayload with EquatableMixin {
  const FetchCreatedTacksPayload({
    super.lastObjectId,
    super.nextPage,
  });

  @override
  List<Object?> get props => <Object?>[
    lastObjectId,
    nextPage,
  ];
}