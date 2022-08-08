part of tacks;

class GroupTacksPayload extends Equatable {
  final int groupId;

  const GroupTacksPayload({
    required this.groupId,
  });

  @override
  List<Object> get props => <Object>[
        groupId,
      ];
}
