part of groups_entities;

@JsonSerializable(createFactory: false)
@FileConverter()
class CreateGroupRequest extends JsonSerializable {
  final String name;
  final String description;
  final File image;
  @JsonKey(name: 'is_public')
  final bool isPublic;

  const CreateGroupRequest({
    required this.name,
    required this.description,
    required this.image,
    this.isPublic = true,
  });

  @override
  Map<String, dynamic> toJson() => _$CreateGroupRequestToJson(this);
}
