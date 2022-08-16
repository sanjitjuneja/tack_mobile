part of groups;

class GroupInvite extends Equatable {
  final Group? group;
  final GroupInvitation? invitation;

  const GroupInvite({
    required this.group,
    required this.invitation,
  });

  @override
  List<Object?> get props => <Object?>[
        group,
        invitation,
      ];
}
