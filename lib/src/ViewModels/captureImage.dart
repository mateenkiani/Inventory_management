import 'dart:io';

// import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
// import './uploader.dart';

class CaptureImage {
  File imageFile;

  Future<File> cropImage() async {
    File cropped = await ImageCropper.cropImage(
      sourcePath: imageFile.path,
      // ratioX: 1.0,
      // ratioY: 1.0,
      // maxWidth: 512,
      // maxHeight: 512,
    );

    // setState(() {
    //   _imageFile = cropped ?? _imageFile;
    // });

    return cropped ?? imageFile;
  }

  /// Select an image via gallery or camera
  Future<File> pickImage(ImageSource source) async {
    PickedFile selected = await new ImagePicker().getImage(source: source);
    // setState(() {
    //   _imageFile = File(selected.path);
    // });
    return File(selected.path);
  }

  /// Remove image
  // void _clear() {
  //   setState(() => _imageFile = null);
  // }

  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     // Select an image from the camera or gallery
  //     bottomNavigationBar: BottomAppBar(
  //       child: Row(
  //         children: <Widget>[
  //           IconButton(
  //             icon: Icon(Icons.photo_camera),
  //             onPressed: () => _pickImage(ImageSource.camera),
  //           ),
  //           IconButton(
  //             icon: Icon(Icons.photo_library),
  //             onPressed: () => _pickImage(ImageSource.gallery),
  //           ),
  //         ],
  //       ),
  //     ),

  //     // Preview the image and crop it
  //     body: ListView(
  //       children: <Widget>[
  //         if (_imageFile != null) ...[
  //           Image.file(_imageFile),
  //           Row(
  //             children: <Widget>[
  //               FlatButton(
  //                 child: Icon(Icons.crop),
  //                 onPressed: _cropImage,
  //               ),
  //               FlatButton(
  //                 child: Icon(Icons.refresh),
  //                 onPressed: _clear,
  //               ),
  //             ],
  //           ),
  //           Uploader(file: _imageFile)
  //         ]
  //       ],
  //     ),
  //   );
  // }
}
