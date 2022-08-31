part of tacks_entities;

class FetchTackOffersRequest extends PaginationRequest {
  final int tackId;

  const FetchTackOffersRequest({
    required this.tackId,
    required super.lastObjectId,
    required super.queryParameters,
  });
}
