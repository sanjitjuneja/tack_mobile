part of 'global_bloc.dart';

abstract class GlobalEvent {
  const GlobalEvent();
}

class AppRefreshAction extends GlobalEvent {
  const AppRefreshAction();
}

class UserChanged extends GlobalEvent {
  final User user;

  const UserChanged({
    required this.user,
  });
}

class CurrentGroupChanged extends GlobalEvent {
  final Group? group;

  const CurrentGroupChanged({
    required this.group,
  });
}

class GroupsCountChanged extends GlobalEvent {
  final int groupsCount;

  const GroupsCountChanged({
    required this.groupsCount,
  });
}

class ChangeGroup extends GlobalEvent {
  const ChangeGroup();
}

class GoToMyInvitations extends GlobalEvent {
  const GoToMyInvitations();
}

class GoToMyGroups extends GlobalEvent {
  const GoToMyGroups();
}

class CompletedTackTackIntentAction extends GlobalEvent {
  final WebSocketIntent<Tack> tackIntent;

  const CompletedTackTackIntentAction({
    required this.tackIntent,
  });
}

class CancelTackerTackRunnerIntentAction extends GlobalEvent {
  final WebSocketIntent<Tack> tackIntent;

  const CancelTackerTackRunnerIntentAction({
    required this.tackIntent,
  });
}

class RunnerTackIntentAction extends GlobalEvent {
  final WebSocketIntent<RunnerTack> tackIntent;

  const RunnerTackIntentAction({
    required this.tackIntent,
  });
}

class TackerTackIntentAction extends GlobalEvent {
  final WebSocketIntent<Tack> tackIntent;

  const TackerTackIntentAction({
    required this.tackIntent,
  });
}
