part of groups;

class FetchGroupMembersPayload extends PaginationPayload with EquatableMixin {
  final Group group;

  const FetchGroupMembersPayload({
    required this.group,
    super.lastObjectId,
    super.nextPage,
  });

  @override
  List<Object?> get props => <Object?>[
        group,
        lastObjectId,
        nextPage,
      ];
}
