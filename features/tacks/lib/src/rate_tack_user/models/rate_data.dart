class RateData {
  final int minRate;
  final int maxRate;
  final bool isRequired;
  final double rate;

  bool get isValid => isRequired ? rate > 0 : true;

  const RateData({
    required this.minRate,
    required this.maxRate,
    required this.isRequired,
    this.rate = 0,
  });

  RateData copyWith({double? rate}) {
    return RateData(
      minRate: minRate,
      maxRate: maxRate,
      isRequired: isRequired,
      rate: rate ?? this.rate,
    );
  }
}
