part of 'create_group_bloc.dart';

abstract class CreateGroupEvent {
  const CreateGroupEvent();
}

class CreateGroupRequest extends CreateGroupEvent {
  const CreateGroupRequest();
}

class CreateGroupNameChange extends CreateGroupEvent {
  final String name;

  const CreateGroupNameChange(this.name);
}

class CreateGroupDescriptionChange extends CreateGroupEvent {
  final String description;

  const CreateGroupDescriptionChange(this.description);
}

class CreateGroupPickPhoto extends CreateGroupEvent {
  const CreateGroupPickPhoto();
}

class CreateGroupDeletePhoto extends CreateGroupEvent {
  const CreateGroupDeletePhoto();
}
