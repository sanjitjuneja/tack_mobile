part of 'group_bloc.dart';

abstract class GroupEvent {
  const GroupEvent();
}

class ChangeGroup extends GroupEvent {
  const ChangeGroup();
}
