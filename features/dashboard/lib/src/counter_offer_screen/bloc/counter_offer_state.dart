part of 'counter_offer_bloc.dart';

class CounterOfferState {
  final GroupTack groupTack;
  final CounterOfferData counterOfferData;

  bool get isReadyToProceed => counterOfferData.isValid;

  const CounterOfferState({
    required this.groupTack,
    required this.counterOfferData,
  });

  CounterOfferState copyWith({
    String? counterOffer,
    bool? isValidationEnabled,
  }) {
    return CounterOfferState(
      groupTack: groupTack,
      counterOfferData: counterOfferData.copyWith(
        counterOfferValue: counterOffer,
        isValidationEnabled: isValidationEnabled,
      ),
    );
  }
}
