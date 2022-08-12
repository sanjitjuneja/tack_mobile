class PriceData {
  final int maxValue;
  final bool isRequired;
  final bool isValidationEnabled;
  final String price;

  /// Used for Business Logic
  bool get isValid => isRequired ? price.isNotEmpty : true;

  /// Used for UI
  bool get isInvalid => isValidationEnabled ? !isValid : false;

  bool isDataChanged(double? oldPrice) {
    return double.tryParse(price) != oldPrice;
  }

  double get parsedPrice => double.parse(price);

  const PriceData({
    required this.maxValue,
    required this.isRequired,
    this.isValidationEnabled = false,
    String? price,
  }) : price = price ?? '';

  PriceData copyWith({
    String? price,
    bool? isValidationEnabled,
  }) {
    return PriceData(
      maxValue: maxValue,
      isRequired: isRequired,
      isValidationEnabled: isValidationEnabled ?? this.isValidationEnabled,
      price: price ?? this.price,
    );
  }

  PriceData empty() {
    return PriceData(
      maxValue: maxValue,
      isRequired: isRequired,
      isValidationEnabled: false,
      price: '',
    );
  }
}
