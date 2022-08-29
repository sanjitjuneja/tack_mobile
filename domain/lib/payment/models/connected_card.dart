part of payment;

class ConnectedCard extends Equatable {
  final String id;
  final String type;
  final ConnectedCardData cardData;

  const ConnectedCard({
    required this.id,
    required this.type,
    required this.cardData,
  });

  @override
  List<Object?> get props => <Object?>[
        id,
        type,
        cardData,
      ];
}
