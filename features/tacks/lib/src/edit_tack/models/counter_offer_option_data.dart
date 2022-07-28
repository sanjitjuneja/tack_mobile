class CounterOfferData {
  final bool isRequired;
  final bool allow;

  bool get isValid => true;

  bool isDataChanged(bool oldCounterOfferOption) {
    return allow != oldCounterOfferOption;
  }

  const CounterOfferData({
    required this.isRequired,
    this.allow = false,
  });

  CounterOfferData copyWith({bool? allow}) {
    return CounterOfferData(
      isRequired: isRequired,
      allow: allow ?? this.allow,
    );
  }
}
