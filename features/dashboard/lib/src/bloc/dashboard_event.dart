part of 'dashboard_bloc.dart';

abstract class DashboardEvent {
  const DashboardEvent();
}

class CounterOfferOpen extends DashboardEvent {
  final TackModel tack;

  const CounterOfferOpen({
    required this.tack,
  });
}

class AcceptTack extends DashboardEvent {
  final TackModel tack;

  const AcceptTack({
    required this.tack,
  });
}
