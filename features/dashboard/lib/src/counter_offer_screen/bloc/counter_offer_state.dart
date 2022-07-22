part of 'counter_offer_bloc.dart';

class CounterOfferState {
  final Tack tack;
  final String? counterOffer;

  bool get isOfferValid => counterOffer != null && counterOffer!.isNotEmpty;

  const CounterOfferState({
    required this.tack,
    this.counterOffer,
  });

  CounterOfferState copyWith({
    String? counterOffer,
  }) {
    return CounterOfferState(
      tack: tack,
      counterOffer: counterOffer ?? this.counterOffer,
    );
  }
}
