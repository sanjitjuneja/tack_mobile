part of tacks;

class RateTackPayload extends Equatable {
  final int tackId;
  final String comment;
  final int rating;

  const RateTackPayload({
    required this.tackId,
    required this.comment,
    required this.rating,
  });

  @override
  List<Object> get props => <Object>[
        tackId,
        comment,
        rating,
      ];
}
