part of tacks_entities;

class FetchGroupsTacksRequest extends PaginationRequest {
  final int groupId;

  const FetchGroupsTacksRequest({
    required this.groupId,
    required super.lastObjectId,
    required super.queryParameters,
  });
}
