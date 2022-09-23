part of 'ongoing_runner_tack_bloc.dart';

abstract class OngoingRunnerTackEvent {
  const OngoingRunnerTackEvent();
}

class RefreshAction extends OngoingRunnerTackEvent {
  const RefreshAction();
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

class MessageTacker extends OngoingRunnerTackEvent {
  const MessageTacker();
}

class CallTacker extends OngoingRunnerTackEvent {
  const CallTacker();
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

class CompletedTackTackIntentAction extends OngoingRunnerTackEvent {
  final WebSocketIntent<Tack> tackIntent;

  const CompletedTackTackIntentAction({
    required this.tackIntent,
  });
}
