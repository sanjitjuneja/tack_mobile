part of 'counter_offer_bloc.dart';

class CounterOfferState {
  final Tack tack;
  final CounterOfferData counterOfferData;

  bool get isReadyToProceed => counterOfferData.isValid;

  const CounterOfferState({
    required this.tack,
    required this.counterOfferData,
  });

  CounterOfferState copyWith({
    String? counterOffer,
  }) {
    return CounterOfferState(
      tack: tack,
      counterOfferData: counterOfferData.copyWith(
        counterOfferValue: counterOffer,
      ),
    );
  }
}
