part of 'previous_tacks_bloc.dart';

abstract class PreviousTacksEvent {
  const PreviousTacksEvent();
}

class InitialLoad extends PreviousTacksEvent {
  const InitialLoad();
}

class RefreshCreatedTacks extends PreviousTacksEvent {
  final Completer<RefreshingStatus>? completer;

  const RefreshCreatedTacks({
    this.completer,
  });
}

class LoadCreatedTacks extends PreviousTacksEvent {
  final Completer<LoadingStatus> completer;

  const LoadCreatedTacks({
    required this.completer,
  });
}

class RefreshCompletedTacks extends PreviousTacksEvent {
  final Completer<RefreshingStatus>? completer;

  const RefreshCompletedTacks({
    this.completer,
  });
}

class LoadCompletedTacks extends PreviousTacksEvent {
  final Completer<LoadingStatus> completer;

  const LoadCompletedTacks({
    required this.completer,
  });
}

class OpenOptions extends PreviousTacksEvent {
  const OpenOptions();
}

class MoveToCreateTackTab extends PreviousTacksEvent {
  const MoveToCreateTackTab();
}

class MoveToHomeTab extends PreviousTacksEvent {
  const MoveToHomeTab();
}
