part of payment;

class ConnectedCard extends Equatable {
  final String id;
  final String type;
  final ConnectedCardData cardData;
  final bool isPrimary;

  const ConnectedCard({
    required this.id,
    required this.type,
    required this.cardData,
    required this.isPrimary,
  });

  @override
  List<Object?> get props => <Object?>[
        id,
        type,
        cardData,
        isPrimary,
      ];
}
