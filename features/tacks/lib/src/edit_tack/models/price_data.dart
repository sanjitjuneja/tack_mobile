class PriceData {
  final int maxValue;
  final bool isRequired;
  final String price;

  bool get isValid => isRequired ? price.isNotEmpty : true;

  bool isDataChanged(double oldPrice) {
    return double.tryParse(price) != oldPrice;
  }

  double get parsedPrice => double.parse(price);

  const PriceData({
    required this.maxValue,
    required this.isRequired,
    this.price = '',
  });

  PriceData copyWith({String? price}) {
    return PriceData(
      maxValue: maxValue,
      isRequired: isRequired,
      price: price ?? this.price,
    );
  }
}
