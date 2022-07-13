import 'dart:io';

class GroupPhotoData {
  final File? imageFile;
  final bool isRequired;

  bool get isValid => isRequired ? imageFile != null : true;

  bool get hasData => imageFile != null;

  const GroupPhotoData({
    required this.isRequired,
    this.imageFile,
  });

  GroupPhotoData copyWith({File? imageFile}) {
    return GroupPhotoData(
      isRequired: isRequired,
      imageFile: imageFile,
    );
  }
}
