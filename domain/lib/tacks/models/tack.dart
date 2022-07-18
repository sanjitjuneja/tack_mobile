part of tacks;

class Tack extends Equatable {
  final int id;
  final String title;
  final double price;
  final String description;
  final DateTime createdAt;
  final DateTime expiresAt;
  final bool allowCounterOffers;
  final TackStatus status;
  final int tacker;
  final int? runner;
  final String? completionMessage;
  final DateTime? completionTime;

  const Tack({
    required this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.createdAt,
    required this.expiresAt,
    required this.allowCounterOffers,
    required this.status,
    required this.tacker,
    required this.runner,
    required this.completionMessage,
    required this.completionTime,
  });

  @override
  List<Object?> get props => <Object?>[
        id,
        title,
        price,
        description,
        createdAt,
        expiresAt,
        allowCounterOffers,
        status,
        tacker,
        runner,
        completionMessage,
        completionTime,
      ];
}
