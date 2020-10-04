import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:inventory_management/src/Models/product.dart';

class FirestoreService {
  final databaseReference = FirebaseFirestore.instance;

  Future<void> addRecord(Product product, Function onError) async {
    try {
      var products = FirebaseFirestore.instance.collection('products');

      products
          .add(product.toMap())
          .then((value) => print("value" + value.toString()))
          .catchError((err) => onError(err));

      // await FirebaseFirestore.instance
      //     .collection("products")
      //     .doc()
      //     .set(product.toMap())
      //     .catchError((err) {
      //   print("error is" + err.toString());
      // });
    } on PlatformException catch (e) {
      print("eee" + e.toString());
    }
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
