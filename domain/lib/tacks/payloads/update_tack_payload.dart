part of tacks;

class UpdateTackPayload extends Equatable {
  final int tackId;
  final String title;
  final int price;
  final String description;
  final int? estimatedTime;
  final bool shouldAllowCounterOffers;

  UpdateTackPayload({
    required this.tackId,
    required this.title,
    required double price,
    required this.description,
    required this.estimatedTime,
    required this.shouldAllowCounterOffers,
  }) : price = (price * 100).toInt();

  @override
  List<Object?> get props => <Object?>[
        tackId,
        title,
        price,
        description,
        estimatedTime,
        shouldAllowCounterOffers,
      ];
}
