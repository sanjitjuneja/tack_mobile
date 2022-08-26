part of groups_entities;

@JsonSerializable()
class GroupDetailsEntity extends JsonSerializable {
  final GroupEntity group;
  @JsonKey(name: 'is_muted')
  final bool isMuted;

  const GroupDetailsEntity({
    required this.group,
    required this.isMuted,
  });

  factory GroupDetailsEntity.fromJson(Map<String, dynamic> json) {
    return _$GroupDetailsEntityFromJson(json);
  }

  @override
  Map<String, dynamic> toJson() => _$GroupDetailsEntityToJson(this);
}
