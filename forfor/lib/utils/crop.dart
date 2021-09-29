import 'dart:io';

import 'package:image_cropper/image_cropper.dart';

class Crop {
  Future<File> cropImage(filePath) async {
    File? croppedImage = await ImageCropper.cropImage(
      sourcePath: filePath,
      maxWidth: 1080,
      maxHeight: 1080,
    );
    return croppedImage!;
  }
}
