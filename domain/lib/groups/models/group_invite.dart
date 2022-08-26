part of groups;

class GroupInvite extends Equatable {
  final GroupDetails? groupDetails;
  final GroupInvitation? invitation;

  const GroupInvite({
    required this.groupDetails,
    required this.invitation,
  });

  @override
  List<Object?> get props => <Object?>[
        groupDetails,
        invitation,
      ];
}
