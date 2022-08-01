class CounterOfferData {
  final bool isRequired;
  final bool allow;

  bool get isValid => true;

  bool isDataChanged(bool? oldCounterOfferOption) {
    oldCounterOfferOption ??= false;

    return allow != oldCounterOfferOption;
  }

  const CounterOfferData({
    required this.isRequired,
    bool? allow,
  }) : allow = allow ?? false;

  CounterOfferData copyWith({bool? allow}) {
    return CounterOfferData(
      isRequired: isRequired,
      allow: allow ?? this.allow,
    );
  }

  CounterOfferData empty() {
    return CounterOfferData(
      isRequired: isRequired,
      allow: false,
    );
  }
}
