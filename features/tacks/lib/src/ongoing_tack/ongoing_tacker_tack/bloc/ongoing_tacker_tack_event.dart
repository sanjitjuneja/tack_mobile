part of 'ongoing_tacker_tack_bloc.dart';

abstract class OngoingTackerTackEvent {
  const OngoingTackerTackEvent();
}

class FetchUserContactsAction extends OngoingTackerTackEvent {
  const FetchUserContactsAction();
}

class ActionPressed extends OngoingTackerTackEvent {
  const ActionPressed();
}

class CancelTack extends OngoingTackerTackEvent {
  const CancelTack();
}

class ContactRunner extends OngoingTackerTackEvent {
  const ContactRunner();
}

class SelectOffer extends OngoingTackerTackEvent {
  final Offer offer;

  const SelectOffer({
    required this.offer,
  });
}

class TackIntentAction extends OngoingTackerTackEvent {
  final WebSocketIntent<Tack> tackIntent;

  const TackIntentAction({
    required this.tackIntent,
  });
}
