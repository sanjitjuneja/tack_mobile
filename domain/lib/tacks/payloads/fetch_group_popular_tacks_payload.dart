part of tacks;

class FetchGroupPopularTacksPayload extends Equatable {
  final int groupId;

  const FetchGroupPopularTacksPayload({
    required this.groupId,
  });

  @override
  List<Object> get props => <Object>[
    groupId,
  ];
}
