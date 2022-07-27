part of tacks;

class RateTackPayload {
  final int tackId;
  final String comment;
  final int rating;

  const RateTackPayload({
    required this.tackId,
    required this.comment,
    required this.rating,
  });
}
