import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:inventory_management/src/Models/SellProduct.dart';
import 'package:inventory_management/src/Models/product.dart';

class SellProductViewModel {
  final _productsRef = FirebaseFirestore.instance.collection('sellers');

  Future<void> addRecord(SellProduct product) async {
    try {
      _productsRef
          .add(product.toMap())
          .then((value) => print("value" + value.toString()))
          .catchError((err) => print(err));
    } on PlatformException catch (e) {
      print("error selling product" + e.toString());
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

  Future<void> updatePrice(String docID, double price) {
    return _productsRef
        .doc(docID)
        .update({
          'price': price,
        })
        .then((value) => print("Price Changed"))
        .catchError((error) => print("Failed to delete user: $error"));
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
