part of 'dashboard_bloc.dart';

abstract class DashboardEvent {
  const DashboardEvent();
}

class GoToCreateTack extends DashboardEvent {
  const GoToCreateTack();
}

class InitialLoad extends DashboardEvent {
  const InitialLoad();
}

class RefreshAction extends DashboardEvent {
  final Completer<RefreshingStatus>? completer;

  const RefreshAction({
    this.completer,
  });
}

class LoadMoreAction extends DashboardEvent {
  final Completer<LoadingStatus> completer;

  const LoadMoreAction({
    required this.completer,
  });
}

class GroupTackIntentAction extends DashboardEvent {
  final WebSocketIntent<GroupTack> groupTackIntent;

  const GroupTackIntentAction({
    required this.groupTackIntent,
  });
}

class OpenOwnRunningOngoingTack extends DashboardEvent {
  final GroupTack groupTack;

  const OpenOwnRunningOngoingTack({
    required this.groupTack,
  });
}

class OpenOwnCreatedOngoingTack extends DashboardEvent {
  final GroupTack groupTack;

  const OpenOwnCreatedOngoingTack({
    required this.groupTack,
  });
}

class CounterOfferOpen extends DashboardEvent {
  final GroupTack groupTack;

  const CounterOfferOpen({
    required this.groupTack,
  });
}

class AcceptTack extends DashboardEvent {
  final GroupTack groupTack;

  const AcceptTack({
    required this.groupTack,
  });
}
