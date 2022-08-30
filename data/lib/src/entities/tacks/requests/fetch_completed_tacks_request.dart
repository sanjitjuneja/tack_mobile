part of tacks_entities;

class FetchCompletedTacksRequest extends PaginationRequest {
  const FetchCompletedTacksRequest({
    required super.lastObjectId,
    required super.queryParameters,
  });
}
