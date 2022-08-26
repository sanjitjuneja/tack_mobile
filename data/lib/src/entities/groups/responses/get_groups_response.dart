part of groups_entities;

@JsonSerializable()
class GetGroupsResponse extends JsonSerializable {
  final int count;
  final String? previous;
  final String? next;
  final List<GroupDetailsEntity> results;

  const GetGroupsResponse({
    required this.count,
    required this.previous,
    required this.next,
    required this.results,
  });

  factory GetGroupsResponse.fromJson(Map<String, dynamic> json) {
    return _$GetGroupsResponseFromJson(json);
  }

  @override
  Map<String, dynamic> toJson() => _$GetGroupsResponseToJson(this);

}
