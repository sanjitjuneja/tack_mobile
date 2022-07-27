part of 'ongoing_runner_tack_bloc.dart';

abstract class OngoingRunnerTackEvent {
  const OngoingRunnerTackEvent();
}

class ContactTacker extends OngoingRunnerTackEvent {
  const ContactTacker();
}

class CancelTack extends OngoingRunnerTackEvent {
  const CancelTack();
}
