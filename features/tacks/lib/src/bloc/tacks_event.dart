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

class LoadTacks extends TacksEvent {
  const LoadTacks();
}

class CancelTackOffer extends TacksEvent {
  final String name;

  const CancelTackOffer({
    required this.name,
  });
}
