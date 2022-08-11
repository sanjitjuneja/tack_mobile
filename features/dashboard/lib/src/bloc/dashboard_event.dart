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

class CounterOfferOpen extends DashboardEvent {
  final Tack tack;

  const CounterOfferOpen({
    required this.tack,
  });
}

class AcceptTack extends DashboardEvent {
  final Tack tack;

  const AcceptTack({
    required this.tack,
  });
}
