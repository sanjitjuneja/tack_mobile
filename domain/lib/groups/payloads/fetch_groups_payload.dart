part of groups;

class FetchGroupsPayload extends PaginationPayload with EquatableMixin {
  const FetchGroupsPayload({
    super.lastObjectId,
    super.nextPage,
  });

  @override
  List<Object?> get props => <Object?>[
        lastObjectId,
        nextPage,
      ];
}
