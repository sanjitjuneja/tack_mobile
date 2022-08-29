part of global;

class PaginationPayload {
  final int? lastObjectId;
  final Uri? nextPage;

  Map<String, String>? get queryParameters => nextPage?.queryParameters;

  const PaginationPayload({
    required this.lastObjectId,
    required this.nextPage,
  });
}
