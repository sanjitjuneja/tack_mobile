class CounterOfferData {
  final double minValue;
  final double? maxValue;
  final bool isRequired;
  final bool isValidationEnabled;
  final String counterOfferValue;

  bool get isValid => isRequired ? counterOfferValue.isNotEmpty : true;

  bool get isInvalid {
    if (!isValidationEnabled) return false;

    if (parsedPrice != null && parsedPrice! <= minValue) return true;

    return false;
  }

  double? get parsedPrice => double.tryParse(counterOfferValue);

  const CounterOfferData({
    required this.minValue,
    required this.maxValue,
    required this.isRequired,
    required this.isValidationEnabled,
    this.counterOfferValue = '',
  });

  CounterOfferData copyWith({
    bool? isValidationEnabled,
    String? counterOfferValue,
  }) {
    return CounterOfferData(
      minValue: minValue,
      maxValue: maxValue,
      isRequired: isRequired,
      isValidationEnabled: isValidationEnabled ?? this.isValidationEnabled,
      counterOfferValue: counterOfferValue ?? this.counterOfferValue,
    );
  }
}
