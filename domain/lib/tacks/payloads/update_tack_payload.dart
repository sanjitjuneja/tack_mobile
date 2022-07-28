part of tacks;

class UpdateTackPayload extends Equatable {
  final int tackId;
  final String title;
  final double price;
  final String description;
  final int estimatedTime;
  final bool shouldAllowCounterOffers;

  const UpdateTackPayload({
    required this.tackId,
    required this.title,
    required this.price,
    required this.description,
    required this.estimatedTime,
    required this.shouldAllowCounterOffers,
  });

  @override
  List<Object> get props => <Object>[
        tackId,
        title,
        price,
        description,
        estimatedTime,
        shouldAllowCounterOffers,
      ];
}
