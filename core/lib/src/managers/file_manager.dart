import 'dart:io';
import 'dart:math';
import 'dart:typed_data';

import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

class FileManager {
  // TODO: refactor mimetype to enum instead of string.
  static Future<File> writeTempFile(
    Uint8List data, {
    String? fileName,
    String? mimeType,
  }) async {
    final String resultingFileName = fileName ?? 'temp';
    final String resultingMimeType = mimeType ?? 'txt';
    final String fullFileName = '$resultingFileName.$resultingMimeType';

    final Directory tempDir = await getTemporaryDirectory();
    final File file = await File('${tempDir.path}/$fullFileName').create();
    file.writeAsBytesSync(data);

    return file;
  }

  static Future<XFile?> pickImage(
    ImageSource source, {
    int? imageQuality,
  }) async {
    return ImagePicker().pickImage(
      source: source,
      imageQuality: imageQuality ?? 50,
    );
  }

  static String getFileSizeString({
    required int bytes,
    int decimals = 0,
  }) {
    const List<String> suffixes = <String>['b', 'kb', 'mb', 'gb', 'tb'];
    final int i = (log(bytes) / log(1024)).floor();

    final String size = (bytes / pow(1024, i)).toStringAsFixed(decimals);

    return <String>[size, suffixes[i]].join();
  }
}
