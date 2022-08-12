part of tacks;

class GroupTacksPayload extends Equatable {
  final int groupId;
  final Uri? nextPage;

  const GroupTacksPayload({
    required this.groupId,
    this.nextPage,
  });

  @override
  List<Object?> get props => <Object?>[
        groupId,
        nextPage,
      ];
}
