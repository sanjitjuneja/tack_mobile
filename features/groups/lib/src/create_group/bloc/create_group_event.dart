part of 'create_group_bloc.dart';

abstract class CreateGroupEvent {
  const CreateGroupEvent();
}

class CreateGroupPickPhoto extends CreateGroupEvent {
  const CreateGroupPickPhoto();
}
