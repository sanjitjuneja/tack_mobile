part of 'offers_bloc.dart';

abstract class OffersEvent {
  const OffersEvent();
}

class InitialLoad extends OffersEvent {
  const InitialLoad();
}

class RefreshAction extends OffersEvent {
  final Completer<RefreshingStatus>? completer;

  const RefreshAction({
    this.completer,
  });
}

class LoadMoreAction extends OffersEvent {
  final Completer<LoadingStatus> completer;

  const LoadMoreAction({
    required this.completer,
  });
}

class OfferExpiredAction extends OffersEvent {
  final int offerId;

  const OfferExpiredAction({
    required this.offerId,
  });
}

class OfferIntentAction extends OffersEvent {
  final WebSocketIntent<Offer> offerIntent;

  const OfferIntentAction({
    required this.offerIntent,
  });
}
