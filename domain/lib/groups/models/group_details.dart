part of groups;

class GroupDetails extends Equatable with IdentifiableMixin {
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

  @override
  int get itemId => id;
}
