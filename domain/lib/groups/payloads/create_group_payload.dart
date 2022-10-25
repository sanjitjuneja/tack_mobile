part of groups;

class CreateGroupPayload {
  final String name;
  final String description;
  final File? image;

  const CreateGroupPayload({
    required this.name,
    required this.description,
    required this.image,
  });
}
