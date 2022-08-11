part of groups_entities;

@JsonSerializable()
class GroupInvitationEntity extends JsonSerializable {
  final int id;
  final GroupEntity group;
  final int invitee;

  const GroupInvitationEntity({
    required this.id,
    required this.group,
    required this.invitee,
  });

  factory GroupInvitationEntity.fromJson(Map<String, dynamic> json) {
    return _$GroupInvitationEntityFromJson(json);
  }

  @override
  Map<String, dynamic> toJson() => _$GroupInvitationEntityToJson(this);
}
