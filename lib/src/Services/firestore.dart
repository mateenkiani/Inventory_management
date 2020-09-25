import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final databaseReference = FirebaseFirestore.instance;

  void createRecord() async {
    await databaseReference.collection("books").doc("1").set({
      'title': 'Mastering Flutter',
      'description': 'Programming Guide for Dart'
    });

    DocumentReference ref = await databaseReference.collection("books").add({
      'title': 'Flutter in Action',
      'description': 'Complete Programming Guide to learn Flutter'
    });
    print(ref.id);
  }

  void getData() {
    databaseReference.collection("books").get().then((QuerySnapshot snapshot) {
      print(snapshot.toString());
      snapshot.docs.forEach((f) => {
            f.data().forEach((key, value) {
              print(value);
            })
          });
    });
  }
}
