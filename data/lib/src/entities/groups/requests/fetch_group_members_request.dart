part of groups_entities;

class FetchGroupMembersRequest extends PaginationRequest {
  final int groupId;

  const FetchGroupMembersRequest({
    required this.groupId,
    required super.lastObjectId,
    required super.queryParameters,
  });
}
