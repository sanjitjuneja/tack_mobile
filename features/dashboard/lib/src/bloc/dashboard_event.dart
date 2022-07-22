part of 'dashboard_bloc.dart';

abstract class DashboardEvent {
  const DashboardEvent();
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
