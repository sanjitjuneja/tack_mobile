part of groups;

class FetchGroupInvitationsPayload extends PaginationPayload
    with EquatableMixin {
  const FetchGroupInvitationsPayload({
    super.lastObjectId,
    super.nextPage,
  });

  @override
  List<Object?> get props => <Object?>[
        lastObjectId,
        nextPage,
      ];
}
