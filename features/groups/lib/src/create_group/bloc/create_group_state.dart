part of 'create_group_bloc.dart';

class CreateGroupState {
  final NameData nameData;
  final DescriptionData descriptionData;
  final GroupPhotoData groupPhotoData;

  bool get isReadyToProceed =>
      nameData.isValid && descriptionData.isValid && groupPhotoData.isValid;

  const CreateGroupState({
    required this.nameData,
    required this.descriptionData,
    required this.groupPhotoData,
  });

  CreateGroupState copyWith({
    String? name,
    String? description,
    File? groupImage,
  }) {
    return CreateGroupState(
      nameData: name != null ? nameData.copyWith(name: name) : nameData,
      descriptionData: description != null
          ? descriptionData.copyWith(description: description)
          : descriptionData,
      groupPhotoData: groupPhotoData.copyWith(imageFile: groupImage),
    );
  }
}
