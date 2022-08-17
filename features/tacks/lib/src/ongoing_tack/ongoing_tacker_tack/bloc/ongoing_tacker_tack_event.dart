part of 'ongoing_tacker_tack_bloc.dart';

abstract class OngoingTackerTackEvent {
  const OngoingTackerTackEvent();
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
