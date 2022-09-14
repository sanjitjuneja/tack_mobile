part of 'tacks_bloc.dart';

abstract class TacksEvent {
  const TacksEvent();
}

class MoveToHomeTab extends TacksEvent {
  const MoveToHomeTab();
}

class MoveToAddTab extends TacksEvent {
  const MoveToAddTab();
}

class InitialLoad extends TacksEvent {
  const InitialLoad();
}

class RefreshRunnerTacks extends TacksEvent {
  final Completer<RefreshingStatus>? completer;

  const RefreshRunnerTacks({
    this.completer,
  });
}

class RefreshTackerTacks extends TacksEvent {
  final Completer<RefreshingStatus>? completer;

  const RefreshTackerTacks({
    this.completer,
  });
}

class RunnerTackIntentAction extends TacksEvent {
  final WebSocketIntent<RunnerTack> tackIntent;

  const RunnerTackIntentAction({
    required this.tackIntent,
  });
}

class TackerTackIntentAction extends TacksEvent {
  final WebSocketIntent<Tack> tackIntent;

  const TackerTackIntentAction({
    required this.tackIntent,
  });
}

class RunnerTackOfferExpired extends TacksEvent {
  final RunnerTack runnerTack;

  const RunnerTackOfferExpired({
    required this.runnerTack,
  });
}

class CancelTackOffer extends TacksEvent {
  final RunnerTack runnerTack;

  const CancelTackOffer({
    required this.runnerTack,
  });
}

class OpenTackerTack extends TacksEvent {
  final Tack tack;

  const OpenTackerTack({
    required this.tack,
  });
}

class OpenRunnerTack extends TacksEvent {
  final RunnerTack runnerTack;

  const OpenRunnerTack({
    required this.runnerTack,
  });
}
