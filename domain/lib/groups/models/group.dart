part of groups;

class Group extends Equatable {
  final int id;
  final int ownerId;
  final String name;
  final String description;
  final String imageUrl;
  final bool isPublic;
  final bool isAnonymous;
  final int memberCount;

  const Group({
    required this.id,
    required this.ownerId,
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.isPublic,
    required this.isAnonymous,
    required this.memberCount,
  });

  @override
  List<Object> get props => <Object>[
        id,
        ownerId,
        name,
        description,
        imageUrl,
        isPublic,
        isAnonymous,
        memberCount,
      ];
}
