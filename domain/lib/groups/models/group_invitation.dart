part of groups;

class GroupInvitation extends Equatable {
  final int id;
  final Group group;
  final int invitee;

  const GroupInvitation({
    required this.id,
    required this.group,
    required this.invitee,
  });

  @override
  List<Object> get props => <Object>[
        id,
        group,
        invitee,
      ];
}
