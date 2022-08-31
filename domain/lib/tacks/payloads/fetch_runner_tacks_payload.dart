part of tacks;

class FetchRunnerTacksPayload extends PaginationPayload with EquatableMixin {
  const FetchRunnerTacksPayload({
    super.lastObjectId,
    super.nextPage,
  });

  @override
  List<Object?> get props => <Object?>[
        lastObjectId,
        nextPage,
      ];
}
