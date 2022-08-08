part of 'create_tack_bloc.dart';

abstract class CreateTackEvent {
  const CreateTackEvent();
}

class InitialLoad extends CreateTackEvent {
  const InitialLoad();
}

class GroupChanged extends CreateTackEvent {
  final Group? group;

  const GroupChanged({
    required this.group,
  });
}

class RefreshNearbyTacks extends CreateTackEvent {
  final Completer<RefreshingStatus>? completer;

  const RefreshNearbyTacks({
    this.completer,
  });
}

class RefreshGroupTacks extends CreateTackEvent {
  final Completer<RefreshingStatus>? completer;

  const RefreshGroupTacks({
    this.completer,
  });
}

class CreateTackAction extends CreateTackEvent {
  final TemplateTack? tack;

  const CreateTackAction({
    this.tack,
  });
}
