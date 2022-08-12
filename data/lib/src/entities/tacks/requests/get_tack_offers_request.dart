part of tacks_entities;

class GetTackOffersRequest extends JsonSerializable {
  final int tackId;
  final Map<String, String>? queryParameters;

  const GetTackOffersRequest({
    required this.tackId,
    this.queryParameters,
  });
}
