part of groups_entities;

@JsonSerializable()
class GetGroupMembersResponse extends JsonSerializable {
  final int count;
  final String? previous;
  final String? next;
  final List<TackUserEntity> results;

  const GetGroupMembersResponse({
    required this.count,
    required this.previous,
    required this.next,
    required this.results,
  });

  factory GetGroupMembersResponse.fromJson(Map<String, dynamic> json) {
    return _$GetGroupMembersResponseFromJson(json);
  }

  @override
  Map<String, dynamic> toJson() => _$GetGroupMembersResponseToJson(this);

}
