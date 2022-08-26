part of groups;

class GroupDetails extends Equatable {
  final Group group;
  final bool isMuted;

  const GroupDetails({
    required this.group,
    required this.isMuted,
  });

  @override
  List<Object> get props => <Object>[
        group,
        isMuted,
      ];
}
