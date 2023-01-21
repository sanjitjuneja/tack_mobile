part of groups_entities;

@JsonSerializable(createFactory: false)
@FileConverter()
class CreateGroupRequest extends JsonSerializable {
  final String name;
  final String description;
  final File image;
  @JsonKey(name: 'is_public')
  final bool isPublic;
  @JsonKey(name: 'is_anonymous')
  final bool isAnonymous;
  final int memberCount;

  const CreateGroupRequest({
    required this.name,
    required this.description,
    required this.image,
    required this.isPublic,
    required this.isAnonymous,
    required this.memberCount,
  });

  @override
  Map<String, dynamic> toJson() => _$CreateGroupRequestToJson(this);
}
