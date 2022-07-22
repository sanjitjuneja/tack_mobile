part of tacks;

class Offer extends Equatable {
  final int id;
  final int tackId;
  final TackUser runner;
  final double price;
  final OfferType type;
  final bool isAccepted;
  final DateTime createdAt;
  final Duration lifetime;

  DateTime get expiredAt => createdAt.add(lifetime);

  const Offer({
    required this.id,
    required this.tackId,
    required this.runner,
    required this.price,
    required this.type,
    required this.isAccepted,
    required this.createdAt,
    required this.lifetime,
  });

  @override
  List<Object?> get props => <Object?>[
        id,
        tackId,
        runner,
        price,
        type,
        isAccepted,
        createdAt,
        lifetime,
      ];
}
