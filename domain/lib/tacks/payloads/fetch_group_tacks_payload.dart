part of tacks;

class FetchGroupTacksPayload extends PaginationPayload with EquatableMixin {
  final int groupId;

  const FetchGroupTacksPayload({
    required this.groupId,
    super.lastObjectId,
    super.nextPage,
  });

  @override
  List<Object?> get props => <Object?>[
        groupId,
        lastObjectId,
        nextPage,
      ];
}
