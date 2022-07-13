part of 'create_group_bloc.dart';

class CreateGroupState {
  final File? groupPhoto;

  const CreateGroupState({
    this.groupPhoto,
  });

  CreateGroupState copyWith({
    File? groupPhoto,
  }) {
    return CreateGroupState(
      groupPhoto: groupPhoto ?? this.groupPhoto,
    );
  }
}
