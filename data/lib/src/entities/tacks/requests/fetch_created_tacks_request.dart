part of tacks_entities;

class FetchCreatedTacksRequest extends PaginationRequest {
  const FetchCreatedTacksRequest({
    required super.lastObjectId,
    required super.queryParameters,
  });
}
