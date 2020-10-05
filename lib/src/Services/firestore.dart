import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:inventory_management/src/Models/product.dart';

class FirestoreService {
  var _productsRef = FirebaseFirestore.instance.collection('products');

  Future<void> addRecord(Product product, Function onError) async {
    try {
      _productsRef
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

  Future<void> deleteDocument(String docId) {
    return _productsRef
        .doc(docId)
        .delete()
        .then(
          (value) => print("User Deleted"),
        )
        .catchError(
          (error) => print("Failed to delete user: $error"),
        );
  }

  Future<void> incQuantity(String docID) {
    return _productsRef
        .doc(docID)
        .update({
          'quantity': FieldValue.increment(1),
        })
        .then((value) => print("Count increased"))
        .catchError((error) => print("Failed to delete user: $error"));
  }

  Future<void> decQuantity(String docID) {
    return _productsRef
        .doc(docID)
        .update({
          'quantity': FieldValue.increment(-1),
        })
        .then((value) => print("Count decresed"))
        .catchError((error) => print("Failed to delete user: $error"));
  }

  Future<Product> getDoc(String docID) {
    return _productsRef
        .doc(docID)
        .get()
        .then((value) => Product.fromSnapshot(value))
        .catchError((error) => print("Failed to delete user: $error"));
  }
}
