part of groups;

class Group extends Equatable {
  final int id;
  final int ownerId;
  final String name;
  final String description;
  final String imageUrl;
  final bool isPublic;

  bool get isNotificationsEnabled => true;

  const Group({
    required this.id,
    required this.ownerId,
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.isPublic,
  });

  @override
  List<Object> get props => <Object>[
        id,
        ownerId,
        name,
        description,
        imageUrl,
        isPublic,
      ];
}
