part of 'global_bloc.dart';

abstract class GlobalEvent {
  const GlobalEvent();
}

class ChangeGroup extends GlobalEvent {
  const ChangeGroup();
}
