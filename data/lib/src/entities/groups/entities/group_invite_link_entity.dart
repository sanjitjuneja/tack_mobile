part of groups_entities;

@JsonSerializable()
class GroupInviteLinkEntity extends JsonSerializable {
  @JsonKey(name: 'invite_link')
  final String inviteLink;

  const GroupInviteLinkEntity({
    required this.inviteLink,
  });

  factory GroupInviteLinkEntity.fromJson(Map<String, dynamic> json) {
    return _$GroupInviteLinkEntityFromJson(json);
  }

  @override
  Map<String, dynamic> toJson() => _$GroupInviteLinkEntityToJson(this);
}
