part of payment;

class ConnectedCardData extends Equatable {
  final String brand;
  final String last4;
  final int expYear;
  final int expMonth;

  const ConnectedCardData({
    required this.brand,
    required this.last4,
    required this.expYear,
    required this.expMonth,
  });

  @override
  List<Object?> get props => <Object>[
        brand,
        last4,
        expYear,
        expMonth,
      ];
}
