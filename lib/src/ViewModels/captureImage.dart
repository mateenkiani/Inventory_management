import 'dart:io';

import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class CaptureImage {
  File imageFile;

  Future<File> cropImage() async {
    File cropped = await ImageCropper.cropImage(
      sourcePath: imageFile.path,
    );

    return cropped ?? imageFile;
  }

  Future<File> pickImage(ImageSource source) async {
    PickedFile selected = await new ImagePicker().getImage(source: source);
    return File(selected.path);
  }
}
