part of tacks;

class TemplateTack extends Equatable {
  final String title;
  final double price;
  final String description;
  final Duration estimatedTime;
  final bool allowCounterOffers;

  const TemplateTack({
    required this.title,
    required this.price,
    required this.description,
    required this.estimatedTime,
    required this.allowCounterOffers,
  });

  @override
  List<Object?> get props => <Object?>[
        title,
        price,
        description,
        estimatedTime,
        allowCounterOffers,
      ];
}
