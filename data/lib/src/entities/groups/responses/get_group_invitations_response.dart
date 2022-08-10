part of groups_entities;

@JsonSerializable()
class GetGroupInvitationsResponse extends JsonSerializable {
  final int count;
  final String? previous;
  final String? next;
  final List<GroupInvitationEntity> results;

  const GetGroupInvitationsResponse({
    required this.count,
    required this.previous,
    required this.next,
    required this.results,
  });

  factory GetGroupInvitationsResponse.fromJson(Map<String, dynamic> json) {
    return _$GetGroupInvitationsResponseFromJson(json);
  }

  @override
  Map<String, dynamic> toJson() => _$GetGroupInvitationsResponseToJson(this);

}
