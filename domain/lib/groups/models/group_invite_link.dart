part of groups;

class GroupInviteLink extends Equatable {
  final String link;

  const GroupInviteLink({
    required this.link,
  });

  @override
  List<Object> get props => <Object>[
        link,
      ];
}
