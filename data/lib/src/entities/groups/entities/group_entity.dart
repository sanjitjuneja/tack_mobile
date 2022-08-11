part of groups_entities;

@JsonSerializable()
class GroupEntity extends JsonSerializable {
  final int id;
  @JsonKey(name: 'owner')
  final int ownerId;
  final String name;
  final String description;
  @JsonKey(name: 'image')
  final String? imageUrl;
  @JsonKey(name: 'is_public')
  final bool isPublic;
  @JsonKey(name: 'is_muted')
  final bool isMuted;

  const GroupEntity({
    required this.id,
    required this.ownerId,
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.isPublic,
    required this.isMuted,
  });

  factory GroupEntity.fromJson(Map<String, dynamic> json) {
    return _$GroupEntityFromJson(json);
  }

  @override
  Map<String, dynamic> toJson() => _$GroupEntityToJson(this);
}
