part of groups_entities;

@JsonSerializable()
class GroupInviteEntity extends JsonSerializable {
  final GroupEntity? group;
  final GroupInvitationEntity? invitation;

  const GroupInviteEntity({
    required this.group,
    required this.invitation,
  });

  factory GroupInviteEntity.fromJson(Map<String, dynamic> json) {
    return _$GroupInviteEntityFromJson(json);
  }

  @override
  Map<String, dynamic> toJson() => _$GroupInviteEntityToJson(this);

}
