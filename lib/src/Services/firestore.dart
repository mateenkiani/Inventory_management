import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:inventory_management/src/Models/product.dart';

class FirestoreService {
  final databaseReference = FirebaseFirestore.instance;

  void addRecord(Product product) async {
    FirebaseFirestore.instance
        .collection("products")
        .doc()
        .set(product.toMap());
  }

  void getData() {
    databaseReference.collection("books").get().then((QuerySnapshot snapshot) {
      print(snapshot.toString());
      snapshot.docs.forEach(
        (f) => {
          f.data().forEach(
            (key, value) {
              print(value);
            },
          ),
        },
      );
    });
  }
}
