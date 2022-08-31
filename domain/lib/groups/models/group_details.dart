part of groups;

class GroupDetails extends Equatable {
  final int id;
  final Group group;
  final bool isMuted;

  const GroupDetails({
    required this.id,
    required this.group,
    required this.isMuted,
  });

  @override
  List<Object> get props => <Object>[
        id,
        group,
        isMuted,
      ];
}
