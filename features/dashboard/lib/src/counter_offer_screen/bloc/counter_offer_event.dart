part of 'counter_offer_bloc.dart';

abstract class CounterOfferEvent {
  const CounterOfferEvent();
}

class CounterOfferChange extends CounterOfferEvent {
  final String? counterOffer;

  const CounterOfferChange({
    required this.counterOffer,
  });
}

class CounterOfferSend extends CounterOfferEvent {
  CounterOfferSend();
}
