part of groups;

class CreateGroupPayload {
  final String name;
  final String description;
  final File image;
  final bool isPublic;
  final bool isAnonymous;
  final int memberCount;

  const CreateGroupPayload({
    required this.name,
    required this.description,
    required this.image,
    required this.isPublic,
    required this.isAnonymous,
    required this.memberCount,
  });
}
