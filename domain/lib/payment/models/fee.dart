part of payment;

class Fee extends Equatable {
  final FeeData stripeFeeData;
  final FeeData dwollaFeeData;

  const Fee({
    required this.stripeFeeData,
    required this.dwollaFeeData,
  });

  @override
  List<Object?> get props => <Object?>[
        stripeFeeData,
        dwollaFeeData,
      ];
}
