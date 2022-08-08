class CounterOfferData {
  final double? maxValue;
  final bool isRequired;
  final String counterOfferValue;

  bool get isValid => isRequired ? counterOfferValue.isNotEmpty : true;

  double get parsedPrice => double.parse(counterOfferValue);

  const CounterOfferData({
    required this.maxValue,
    required this.isRequired,
    this.counterOfferValue = '',
  });

  CounterOfferData copyWith({String? counterOfferValue}) {
    return CounterOfferData(
      maxValue: maxValue,
      isRequired: isRequired,
      counterOfferValue: counterOfferValue ?? this.counterOfferValue,
    );
  }
}
