part of tacks;

class GroupPopularTacksPayload extends Equatable {
  final int groupId;

  const GroupPopularTacksPayload({
    required this.groupId,
  });

  @override
  List<Object> get props => <Object>[
    groupId,
  ];
}
