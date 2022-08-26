part of groups_entities;

@JsonSerializable()
class GroupInviteEntity extends JsonSerializable {
  @JsonKey(name: 'group')
  final GroupDetailsEntity? groupDetails;
  final GroupInvitationEntity? invitation;

  const GroupInviteEntity({
    required this.groupDetails,
    required this.invitation,
  });

  factory GroupInviteEntity.fromJson(Map<String, dynamic> json) {
    return _$GroupInviteEntityFromJson(json);
  }

  @override
  Map<String, dynamic> toJson() => _$GroupInviteEntityToJson(this);

}
