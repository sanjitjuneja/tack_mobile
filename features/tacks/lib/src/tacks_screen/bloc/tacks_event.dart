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

class LoadMockedData extends TacksEvent {
  const LoadMockedData();
}

class LoadRunnerTacks extends TacksEvent {
  final Completer<LoadingStatus> completer;

  const LoadRunnerTacks({
    required this.completer,
  });
}

class RefreshRunnerTacks extends TacksEvent {
  final Completer<RefreshingStatus> completer;

  const RefreshRunnerTacks({
    required this.completer,
  });
}

class LoadTackerTacks extends TacksEvent {
  final Completer<LoadingStatus> completer;

  const LoadTackerTacks({
    required this.completer,
  });
}

class RefreshTackerTacks extends TacksEvent {
  final Completer<RefreshingStatus> completer;

  const RefreshTackerTacks({
    required this.completer,
  });
}

class CancelTackOffer extends TacksEvent {
  final Tack tack;

  const CancelTackOffer({
    required this.tack,
  });
}
