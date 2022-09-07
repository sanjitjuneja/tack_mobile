part of payment;

class FeeData extends Equatable {
  final double feePercent;
  final int feeMin;
  final int feeMax;

  const FeeData({
    required this.feePercent,
    required this.feeMin,
    required this.feeMax,
  });

  @override
  List<Object?> get props => <Object?>[
        feePercent,
        feeMin,
        feeMax,
      ];
}
