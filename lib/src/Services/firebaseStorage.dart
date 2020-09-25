import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

class FirebaseStorageService {
  final FirebaseStorage _storage = FirebaseStorage(
      storageBucket: 'gs://inventory-management-95d23.appspot.com');

  FirebaseStorageService();

  Future<String> uploadImage(File file) async {
    String filePath = 'images/${DateTime.now()}.png';
    StorageUploadTask uploadTask = _storage.ref().child(filePath).putFile(file);
    var dowurl = await (await uploadTask.onComplete).ref.getDownloadURL();
    return dowurl.toString();
  }
}
