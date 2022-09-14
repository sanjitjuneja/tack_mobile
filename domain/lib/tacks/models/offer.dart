part of tacks;

class Offer extends Equatable with IdentifiableMixin {
  final int id;
  final int tackId;
  final TackUser runner;
  final double? price;
  final OfferType type;
  final DateTime createdAt;
  final Duration lifetime;

  DateTime get expiredAt => createdAt.add(lifetime);

  const Offer({
    required this.id,
    required this.tackId,
    required this.runner,
    required this.price,
    required this.type,
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
        createdAt,
        lifetime,
      ];

  @override
  int get itemId => id;
}
