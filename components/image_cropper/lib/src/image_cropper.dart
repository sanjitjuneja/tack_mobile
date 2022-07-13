part of image_cropper;

class ImageCropper {
  static const String routeName = '/imageCropper';

  static Page<File?> page({required File file}) {
    return _ImageCropperPage(file: file);
  }
}

class _ImageCropperPage extends Page<File?> {
  final File file;

  @override
  String get name => ImageCropper.routeName;

  const _ImageCropperPage({
    required this.file,
  });

  @override
  Route<File?> createRoute(BuildContext context) {
    return CupertinoPageRoute<File?>(
      settings: this,
      fullscreenDialog: true,
      builder: (_) => _ImageCropperScreen(
        file: file,
      ),
    );
  }
}
