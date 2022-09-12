part of 'ongoing_runner_tack_bloc.dart';

abstract class OngoingRunnerTackEvent {
  const OngoingRunnerTackEvent();
}

class FetchHasRunningTackAction extends OngoingRunnerTackEvent {
  const FetchHasRunningTackAction();
}

class FetchUserContactsAction extends OngoingRunnerTackEvent {
  const FetchUserContactsAction();
}

class ActionPressed extends OngoingRunnerTackEvent {
  const ActionPressed();
}

class ContactTacker extends OngoingRunnerTackEvent {
  const ContactTacker();
}

class CancelTack extends OngoingRunnerTackEvent {
  const CancelTack();
}

class TackIntentAction extends OngoingRunnerTackEvent {
  final WebSocketIntent<RunnerTack> tackIntent;

  const TackIntentAction({
    required this.tackIntent,
  });
}
