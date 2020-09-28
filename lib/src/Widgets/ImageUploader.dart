import 'dart:io';

import 'package:flutter/material.dart';
import 'package:inventory_management/src/Services/firebaseStorage.dart';
import 'package:inventory_management/src/Singleton.dart';

class ImageUploader extends StatefulWidget {
  final File file;
  ImageUploader({@required this.file});

  @override
  _ImageUploaderState createState() => _ImageUploaderState();
}

class _ImageUploaderState extends State<ImageUploader> {
  FirebaseStorageService storageService;
  bool uploading = false;

  @override
  void initState() {
    super.initState();
    storageService = FirebaseStorageService();
  }

  void _uploadImage() async {
    String url = await storageService.uploadImage(widget.file);
    // Singleton.instance.setDownloadUrl(url);
    // print(Singleton.instance.downloadUrl);
  }

  @override
  Widget build(BuildContext context) {
    if (uploading) {
      return Text('Uploading');
    } else {
      return RaisedButton(
        onPressed: _uploadImage,
        child: Text('Upload Image'),
      );
    }
  }
}
